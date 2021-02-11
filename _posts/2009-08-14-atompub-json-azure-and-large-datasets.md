---
category: technology
title: 'AtomPub, JSON, Azure, and Large Datasets'
date: 2009-08-14 00:00
tags:
- cloud computing
- azure
- cloud
- storage
redirect_from:
- /blog/2009/8/14/atompub-json-azure-and-large-datasets.html
- /2009/08/14/atompub-json-azure-and-large-datasets/ 
---

> UPDATE 8/20/2009, 15:29 EST: There is some confusing content in this post (i.e. Azure storage doesn’t support JSON). [A follow up to this post with further explanation/detail is available here](http://rob.gillenfamily.net/post/AtomPub-JSON-Azure-and-Large-Datasets-Part-2.aspx)

---

> UPDATE 8/14/2009, 17:16 EST: @smarx pointed out that this post is a bit misleading (my word) in that Azure storage doesn’t support JSON. I have a web role in place that serves the data, which, upon reflection could be introducing some time delays into the Atom feed. I will test further and update this post.

--- 

I’m just really beginning to scratch the surface on my work on cloud computing and scientific computing but it seems that nearly every day I’m able to spend time on this I come away with something at least moderately novel. Today’s observation is, on reflection, a bit of a no-brainer but it wasn’t immediately obvious to me.

I’m kicking around some scientific data and have a single collection of data, with somewhere north of 40,000 subsets of data, with each subset containing roughly 8,100 rows. I’ve had an interesting time getting this data into Azure tables, but that’s not the point of this post. Once the data resided in Azure, I built a little ADO.NET client to pull the data down based on various queries (in my case, a single “subset” at a time, or 8,100 rows). In case you are wondering, the data is partitioned in Azure based on the key representing each subset, so I know that each query is only hitting a single partition. I proceeded to follow the examples for paging and data calls (checking for continuation tokens, etc.) and it wasn’t long before I had a client that would query for a particular slice of data, and then make however many individual data calls necessary until the complete result set was downloaded and ready for processing. I was, however, disappointed in the time it took to pull down a single slice of data… averages were around 55 seconds. Pulling down a number of slices of the dataset, at nearly a minute each, was a bit slow.

I spent some time poking around with Fiddler and some other tools and discovered that I was suffering from XML bloat. The “convenience” factor of having a common, easy-to-consume format was killing me. Each response coming back from the server (1000 rows) was averaging over 1MB of XML.

After a while of kicking around my options (frankly, too long), I decided to try pulling the data as JSON. I hadn’t used JSON previously, but had heard it touted as being very lightweight. I also found some nice libraries on [CodePlex](http://codeplex.com) for de-serializing the response so I could use it as I had the results of the Atom feed. Once I made this change, I was shocked to see the amount of improvement (I expected some, but what I saw was much more than anticipated). My average time dropped to around 14 seconds for the entire batch and the average size of the response body dropped to about 163k.

I’ve included some charts below showing the results of my tests. I ran the tests 10 times for each of the approaches. Code base for each test harness is identical with the exception of the protocol-specific text handling. Time measurements are from the start of the query through the point that each response has been de-serialized into an identical .NET object (actually, a `List<T>` objects).

These first two charts show the time required to retrieve the entire slice of data. The unit of measure is seconds.

<figure class="align-center" style="width: 500px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_19B74A6E.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_19B74A6E.png" alt="Run Data"></a>
</figure>

<figure class="align-center" style="width: 500px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_74B989F4.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_74B989F4.png" alt="Average Time"></a>
</figure>

These charts show the average payload returned per request for the two different methods. In both cases, the unit of measurement is bytes.

<figure class="align-center" style="width: 500px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_41E98380.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_41E98380.png" alt="Run Data"></a>
</figure>

<figure class="align-center" style="width: 500px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_5FCA9832.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_5FCA9832.png" alt="Average Time"></a>
</figure>