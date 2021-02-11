---
category: technology
title: 'AtomPub, JSON, Azure and Large Datasets, Part 2'
date: 2009-08-20 00:00
tags:
- cloud computing
- azure
- cloud
redirect_from:
- /blog/2009/8/20/atompub-json-azure-and-large-datasets-part-2.html
- /2009/08/20/atompub-json-azure-and-large-datasets-part-2/
---
Last Friday [I posted some initial results]({{ site.url }}{{ site.baseurl }}/technology/2009/08/14/atompub-json-azure-and-large-datasets/) from some simplistic testing I had done comparing pulling data from Azure via ATOM (the ADO.NET data services client) and JSON. I was surprised at the significant difference in payload and time to completion. A little later, Steve Marx questioned my methodology based on the fact that Azure storage doesn’t support JSON. Steve wasn’t being contrary, but rather pushing for clarification to the methodology of my testing as well as a desire to keep people from attempting to exploit the JSON interface of Azure storage when none exists. This post is a follow up to [that one]({{ site.url }}{{ site.baseurl }}/technology/2009/08/14/atompub-json-azure-and-large-datasets/) and attempts to clarify things a bit and highlight some expanded findings.

The platform I’m working against is an Azure account with a storage account hosting the data (Azure Tables), and a web role providing multiple interaction points to the data, as well as making the interaction point anonymous. Essentially, this web role serves as a “proxy” to the data and reformats it as necessary. After Steve’s question last week, I got to wondering particularly about the overhead (if any) the web role/proxy was introducing and if, esp. in the case of the ATOM data, it was drastically affecting the results. I also got to wondering if the delays I was experiencing in data transmission were, in some part, caused by the fact of having to issue 9 serial requests in order to retrieve the entire 8100 rows that satisfied my query.

To address these issues, I made the following adjustments:

1. Tweaked my test harness for ATOM to optionally hit the storage platform directly (bypassing the proxy data service).

2. Tweaked the data service to allow an extra query string parameter to indicate that the proxy service should make as many calls to the data service as necessary to gather the complete result set and then return the results as a single batch to the caller. This allowed me to eliminate the 1000 row limit as well as to issue only a single HTTP request from the client.

3. I increased the test runs from 10 to 20 – still not scientifically accurate by any means, but a bit longer to provide a little better sense of the average lengths for each request batch.

The results I received as follows and not altogether different than one might expect:

<figure class="align-center" style="width: 500px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_5B16CC5E.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_5B16CC5E.png" alt="Run Data"></a>
</figure> 

<figure class="align-center" style="width: 500px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_3FE1040E.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_3FE1040E.png" alt="Average Time"></a>
</figure> 

As you can see from the charts above, the JSON FULL option was the fastest with an average time to completion of 14.4 seconds. When compared to the regular JSON approach, you can infer that the overhead introduced from multiple calls is roughly 4 seconds (18.55 average time to completion).

In the ATOM category, I find it interesting that the difference between the ATOM Direct (directly to the storage service) was only marginally faster (0.2 of a second on average) than the ATOM FULL approach. __*This would indicate that the network calls between the web role and the storage role are almost a non-factor*__ (hinting at rather good network speeds). Remember, in the case of ATOM Full, the web role is doing the exact same thing as the test client is doing in Atom Direct, but additionally bundling the XML response into a single blob (rather than 9) and then sending it back to the client.

The following chart shows the average payload per request between the test harness and Azure. Atom Full is different then Atom and Atom Direct in that the former is all 8,100 rows whereas the later two represent a single batch of 1000. It is interesting to note that the JSON representation of all 8,100 records is only marginally larger than the ATOM representation of 1,000 records (1,326,298 bytes compared to 1,118,892 bytes).

<figure class="align-center" style="width: 500px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_0D10FD9A.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_0D10FD9A.png" alt="Average Payload"></a>
</figure> 

At the end of the day, none of this is too surprising. JSON is less verbose in markup than ATOM and would logically be smaller on the wire and therefore complete sooner (although I wouldn’t have imagined it was a factor of 9 difference). What __*is*__ interesting, is that the transfer of data b/t the data layer and the web role is almost trivially fast (remember, that 9 MB of XML moved between the layers and was then reformatted as JSON and shoved down back to the client in 14 seconds). It further makes you wonder what the performance improvement would/could be if Azure storage exposed a native JSON interface...