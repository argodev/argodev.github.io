---
layout: post
category: technology
title: 'Silverlight and Azure Table Data Paging'
date: 2009-08-05 00:01
tags:
- cloud computing
- azure
- cloud
- silverlight
redirect_from:
- /blog/2009/8/5/silverlight-and-azure-table-data-paging.html
---
I’m [playing around](http://rob.gillenfamily.net/post/Azure-Visualization-and-Large-Datasets.aspx) 
with a data visualization app using Silverlight and data hosted in Azure Tables 
and have been learning quite a bit in the process. Firstly, Azure tables only 
allows you to return 1000 records in a given query. If you issue a query that 
has a larger matching result set, Azure will return some extra headers 
indicating as such (`x-ms-continuation-NextPartitionKey` and 
`x-ms-continuation-NextRowKey`). It wasn’t hard to find an example of data 
paging using Azure table data, however it used the `Execute()` method of the 
`DataServiceQuery` object. Unfortunately, this isn’t available in Silverlight 
as you have to use the asynchronous methods (`BeginQuery` and `EndQuery`). I’m a 
bit slow, and for whatever reason translating the MSDN sample for synchronous to 
the asynchronous model took me longer than it should have. I’m posting this so 
that maybe the next person will find this, get the answer they need, and move on 
and not waste the same amount of time I did.

My button event handler looks quite a bit different from the MSDN sample but is 
pretty easy to figure out:

<img alt='Code Sample 1' src='/images/image_6BBD8CC6.png' class='blogimage img-responsive'>

I instantiate the context, create a query based on that context, cast that query 
as a `DataServiceQuery<t>` and then call the `BeginExecute` method passing my 
callback method and the query as my state object. (Note: in case you are 
wondering about the `Where` clause in the query above, I know that all of the 
data that matches the first conditional is located in a given partition within 
the Azure table and have found that specifying the partition greatly increases 
the performance).

My callback method (`ProcessDataRequest`) does a bit of recursion to support the 
unknown number of subsequent calls needed to retrieve all of the matching 
records.

The contents of the `ProcessDataRequest` method are listed below:

<img alt='Code Sample 2' src='/images/image_18A2C9D5.png' class='blogimage img-responsive'>

Note that unlike some samples that are 
[simply focusing on async data calls](http://social.msdn.microsoft.com/Forums/en-US/adodotnetdataservices/thread/86dd95e1-29d2-415c-96ba-2ffecedcdfe6) 
and don’t handle paging via headers, I cast the output of `EndExecute` as a 
`QueryOperationResponse` object which allows me to subsequently access the 
headers and interrogate them for the continuation keys. If I find the 
continuation keys, I create a new query object, set the additional query 
options, and execute it in the same fashion as the original call.  The 
`AddPointsToScreen` method simply processes the values and renders them as 
polygons to the screen. I’ve included it here not because there is anything 
special in it, but rather for completeness.

<img alt='Code Sample 3' src='/images/image_1DA50784.png' class='blogimage img-responsive'>
