I’m [playing around](/technology/2009/azure-visualization-and-large-datasets) with a data visualization
app using Silverlight and data hosted in Azure Tables and have been learning quite a bit in the process. Firstly,
Azure tables only allows you to return 1000 records in a given query. If you issue a query that has a larger matching
result set, Azure will return some extra headers indicating as such (`x-ms-continuation-NextPartitionKey` and
`x-ms-continuation-NextRowKey`). It wasn’t hard to find [an example of data paging using Azure table data]
(http://msdn.microsoft.com/en-us/library/dd135718.aspx), however it used the `Execute()` method of the
`DataServiceQuery` object. Unfortunately, this isn’t available in Silverlight as you have to use the asynchronous
methods (`BeginQuery` and `EndQuery`). I’m a bit slow, and for whatever reason translating the MSDN sample for
synchronous to the asynchronous model took me longer than it should have. I’m posting this so that maybe the next
person will find this, get the answer they need, and move on and not waste the same amount of time I did.

My button event handler looks quite a bit different from the MSDN sample but is pretty easy to figure out:

    // get a collection of points from the data service
    var context = new data1DataServiceContext();

    var tempSet = context
        .CreateQuery<TemperatureValue>("TemperatureValue")
        .Where(tv => (tv.time == selectedTime) &&
            (tv.PartitionKey == selectedTime.ToString()));

    var query = tempSet as DataServiceQuery<TemperatureValue>;

    // begin the call and grab the first set of data
    query.BeginExecute(
        new AsyncCallback(this.ProcessDataResponse), query);

I instantiate the context, create a query based on that context, cast that query as a `DataServiceQuery<t>` and then
call the `BeginExecute` method passing my callback method and the query as my state object. (Note: in case you are
wondering about the `Where` clause in the query above, I know that all of the data that matches the first conditional
is located in a given partition within the Azure table and have found that specifying the partition greatly increases
the performance).

My callback method (`ProcessDataRequest`) does a bit of recursion to support the unknown number of subsequent calls
needed to retrieve all of the matching records.

The contents of the `ProcessDataRequest` method are listed below:

    var query = ar.AsyncState as DataServiceQuery<TemperatureValue>;
    var response = query.EndExecute(ar) as QueryOperationResponse;

    // add the points to the screen
    this.AddPointsToScreen(response);

    // see if there are more entries waiting
    if (response.Headers.ContainsKey("x-ms-continuation-NextPartitionKey"))
    {
        // get a collection of points from the data service
        var context = new data1DataServiceContext();

        var tempSet = context
            .CreateQuery<TemperatureValue>("TemperatureValue")
            .Where(tv => (tv.time == selectedTime) &&
                (tv.PartitionKey == selectedTime.ToString()));

        var newQuery = tempSet as DataServiceQuery<TemperatureValue>;

        newQuery = newQuery.AddQueryOption("NextPartitionKey",
            response.Headers["x-ms-continuation-NextPartitionKey"]);

        if (response.Headers.ContainsKey("x-ms-continuation-NextRowKey"))
        {
            newQuery = newQuery.AddQueryOption("NextRowKey",
                response.Headers["x-ms-continuation-NextRowKey"]);
        }

        // Ok, now we need to execute it again
        newQuery.BeginExecute(
            new AsyncCallback(this.ProcessDataResponse), newQuery);
    }


Note that unlike some samples that are simply focusing on async data calls and don’t handle paging via headers, I cast
the output of `EndExecute` as a `QueryOperationResponse` object which allows me to subsequently access the headers and
interrogate them for the continuation keys. If I find the continuation keys, I create a new query object, set the
additional query options, and execute it in the same fashion as the original call.  The `AddPointsToScreen` method
simply processes the values and renders them as polygons to the screen. I’ve included it here not because there is
anything special in it, but rather for completeness.

    private void AddPointsToScreen(QueryOperationResponse response)
    {
        foreach (TemperatureValue tv in response)
        {
            double boxSize = 1.45;

            // add to map
            MapPolygon polygon = new MapPolygon();
            polygon.Fill = new SolidColorBrush(HexStringToColor
                (TempToColorString(Convert.ToInt32(tv.tas - 210))));
            polygon.Opacity = 0.6;
            polygon.Locations = new LocationCollection() {
                new Location(tv.lat + boxSize, tv.lon - boxSize),
                new Location(tv.lat + boxSize, tv.lon + boxSize),
                new Location(tv.lat - boxSize, tv.lon + boxSize),
                new Location(tv.lat - boxSize, tv.lon - boxSize)
            };

            polygon.IsHitTestVisible = false;

            TestMap.AddChild(polygon);
        }
    }

