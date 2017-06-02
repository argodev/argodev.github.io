---
layout: post
category: technology
title: 'GeoFences in MongoDB'
date: 2016-09-03 06:11
tags:
- mongodb
- geofence
- samples
description: "I was recently working on a project with a colleague wherein we wanted to allow 
the user of our system to define one or more \"geofences\" for an experiment and 
then evalute each new GPS point and indicate via an alert if the sensor crossed 
any of those lines."
---

I was recently working on a project with a colleague wherein we wanted to allow 
the user of our system to define one or more "geofences" for an experiment and 
then evalute each new GPS point and indicate via an alert if the sensor crossed 
any of those lines. 

This is a common problem in web apps, however we encountered some difficulty 
piecing together all of the steps in a coherent example. As such, I've posted 
the following with the hope it will help others as well as serve as a reference 
for future work.

The constrains of our system include that the data store is MongoDB and the 
fences are stored as an array of objects (with metadata) on each "experiment" 
document. MongoDB refers to these as "subdocuments" or "child documents".

We will start with an document that has a 'fences' array stored in GeoJSON 
format. The following is our example document:

```json
{
    "_id" : ObjectId("57caa555e6644cbc5154dbcd"),
    "name" : "Experiment 01",
    "description" : "Something really interesting",
    "fences" : [ 
        {
            "name" : "Fence01",
            "active" : true,
            "description" : "Red Triangle",
            "polygon" : {
                "coordinates" : [ 
                    [ 
                        [ -83.939852, 35.966559 ], 
                        [ -83.904318, 35.952316 ], 
                        [ -83.935475, 35.943422 ], 
                        [ -83.939852, 35.966559 ]
                    ]
                ],
                "type" : "Polygon"
            },
            "_id" : ObjectId("57caac200e37463195f70c54")
        }, 
        {
            "name" : "Fence02",
            "active" : true,
            "description" : "Green Thing",
            "polygon" : {
                "coordinates" : [ 
                    [ 
                        [ -83.930989, 35.964824 ], 
                        [ -83.918432, 35.965252 ], 
                        [ -83.9183, 35.937539 ], 
                        [ -83.933104, 35.937379 ], 
                        [ -83.930989, 35.964824 ]
                    ]
                ],
                "type" : "Polygon"
            },
            "_id" : ObjectId("57caac5f0e37463195f70c55")
        }
    ]
}
```
> NOTE: MongoDB requires that you store the coordinates as pairs of decimals 
with the longitude first followed by latitude. This also must be valid GeoJSON.

This results in the two polygons shown in the image below. Also, we will 
consider three pins in the image below as A, B, and C, named left to right.

<img alt='GeoFences in MongoDB' src='/images/geofence.png' class='blogimage img-responsive'>

The following is a bit pedantic, but as my high school physics teacher always 
said, "start with what you know"...

__Simple query in Mongo__

```javascript
db.getCollection('experiments').find({
    _id: ObjectId("57caa555e6644cbc5154dbcd")
})
```

__Simple 'and' style query in Mongo using property of subdocument__

```javascript
db.getCollection('experiments').find({
    _id: ObjectId("57caa555e6644cbc5154dbcd"), 
    "fences.name": "Fence01"
})
```

> NOTE: This doesn't grab the subdocument, but rather a record that matches both 
the `_id` property and also has at least one subdocument of `fences` with a 
`name` of `Fence01`

__Creating a 2dsphere index for polygon queries__

I don't believe this is required, but it improves the performance of the 
queries.

```javascript
db.experiments.ensureIndex({"fences.polygon": "2dsphere"})
```

__Now, a query that finds a point within one of the polygons__

Query for a record with a specific ID and at least one fence that contains 
point B.

```javascript
db.getCollection('experiments').find({
    "_id": ObjectId("57caa555e6644cbc5154dbcd"),
    "fences.polygon": {
        $geoIntersects: {
            $geometry:{ 
                "type" : "Point",
                "coordinates" : [ -83.936033, 35.955194 ]
            }
        }
    }
})
```

That is helpful, but not exactly what we need. With multiple fences on a 
single campaign, we need to see not only does one match, but how many do.
That way we can say what has changed between the current GPS point and the
one prior.

For this problem we need to use the MongoDB Aggregation framework. The following 
is an example of using the aggregation framework to query for the child 
documents that match a given name and are under the campaign with the specified 
ID:

```javascript
db.experiments.aggregate([
    {$unwind : "$fences"},
    {$match : {
        "_id": ObjectId("57caa555e6644cbc5154dbcd"), 
        "fences.name" : "Fence01"}},
    {$project : {_id : "$fences._id", 
                 name : "$fences.name", 
                 active : "$fences.active"}}
])
```

This results in an entry like the following:

```json
{
    "_id" : ObjectId("57caac200e37463195f70c54"),
    "name" : "Fence01",
    "active" : true
}
```
> Note that the use of the aggregation framework also allows us to project the 
results of the query into a collection of "differently shaped" documents - in 
this case, a summary of the child documents as individual items.

At this point, we need to adjust it to do the geo query and confirm that it 
works as we expect

```javascript
db.experiments.aggregate([
    {$unwind : "$fences"},
    {$match : {
        "_id": ObjectId("57caa555e6644cbc5154dbcd"), 
        "fences.polygon": {
            $geoIntersects: {
                $geometry:{ 
                    "type" : "Point",
                    "coordinates" : [ -83.936033, 35.955194 ]
                }
            }
        }}
    },
    {$project : {_id : "$fences._id", 
                 name : "$fences.name", 
                 active : "$fences.active"}}
])
```

This worked exactly as we expect and we obtain the record for the red triangle
fence. Now, if we change the query to use the coordinates for point C 
(`{lat: 35.958607, lng: -83.926925}`) we should receive two records in our 
output:

```json
[
    {
        "_id" : ObjectId("57caac200e37463195f70c54"),
        "name" : "Fence01",
        "active" : true
    },
    {
        "_id" : ObjectId("57caac5f0e37463195f70c55"),
        "name" : "Fence02",
        "active" : true
    }
]
```
Which is exactly what we want. One last query with the coordinates from point 
A (`{lat: 35.953033, lng: -83.941981}`) confirms that we get no results:

```json
[]
```

To summarize, the flow for checking whether or not a boundary has been 
crossed is as simple as issuing two queries against the db. One of these will 
take the current GPS lat/lon and see how many (if any) fences interset with it.
The second query takes the prior GPS lan/lon and answers the same question. If 
the answer is different, we know a fence border was crossed and can alert 
appropriately. If we care to indicate which fence, reviewing the difference 
between the data in the two query responses will provide that information.

