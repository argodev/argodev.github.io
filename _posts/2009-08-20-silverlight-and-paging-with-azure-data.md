---
layout: post
category: technology
title: 'SilverLight and Paging with Azure Data'
date: 2009-08-20 00:01
tags:
- cloud computing
- azure
- silverlight
redirect_from:
- /blog/2009/8/20/silverlight-and-paging-with-azure-data.html
---
If you’ve been watching by blog at all lately, you know that I’ve been 
[playing with some larger data sets and Azure storage](http://rob.gillenfamily.net/post/AtomPub-JSON-Azure-and-Large-Datasets-Part-2.aspx), 
specifically Azure table storage. Last week I found myself working with a 
SilverLight application to visualize the resulting data and display it to the
user, however I did not want to use the ADO.NET Data Services client (ATOM) due 
to the size of data in transmission. Consequently, I set up a web role that 
proxied the data calls and fed them back to the caller as JSON. Due to the 
limitation on Azure table storage of only returning 1,000 rows at a time, I 
needed to access the response headers in my SilverLight client to determine 
after each request if there were more rows waiting... and that was the rub... 
every time I tried to access the response headers collection (tried both with a 
`WebClient` and `HttpWebRequest`), I received a `System.NotImplementedException`.

I pounded my head on this for a few days with no success until a helpful 
twitterer ([@silverfighter](https://twitter.com/silverfighter)) provided me a 
link that got me rolling. The root of the problem was my ignorance of how 
SilverLight’s networking stack functioned. As I (now) understand it, by default 
any networking calls (`WebClient` or `HttpWebRequest`) are actually handled by 
the browser and not .NET. This results in you getting access to only what the 
browser object hands you, which in my case, did not include the response headers.

The key here is that SilverLight 3 provides you the ability to tell the browser 
that you’d rather handle those requests yourself. By simply registering the http 
protocol (you can actually do it as granular as a site level) as handled by the 
Silverlight client, “magic” happens and you suddenly have access to the 
properties of the `WebClient` (`ResponseHeaders`) and `HttpWebRequest` 
(`Response.Headers`) objects that you would have expected to. The magic line you 
need to add prior to issuing any calls is as follows:


    bool httpResult = WebRequest.RegisterPrefix("http://", WebRequestCreator.ClientHttp);

 
(yes… that’s it…)


The links to the appropriate articles are as follows:

[http://blogs.msdn.com/carlosfigueira/archive/2009/08/15/fault-support-in-silverlight-3.aspx](http://blogs.msdn.com/carlosfigueira/archive/2009/08/15/fault-support-in-silverlight-3.aspx ) 

[http://msdn.microsoft.com/en-us/library/dd470096(VS.95).aspx](http://msdn.microsoft.com/en-us/library/dd470096(VS.95).aspx)

[http://blogs.msdn.com/silverlight_sdk/archive/2009/08/12/new-networking-stack-in-silverlight-3.aspx](http://blogs.msdn.com/silverlight_sdk/archive/2009/08/12/new-networking-stack-in-silverlight-3.aspx)
