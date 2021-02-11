---
category: technology
title: 'Common API Set for Cloud Storage?'
date: 2009-04-09 00:00
tags:
- cloud computing
- aws
- azure
redirect_from:
- /blog/2009/4/9/common-api-set-for-cloud-storage.html
- /2009/04/09/common-api-set-for-cloud-storage/
---
<img alt='Azure vs Amazon' src='/images/amazon_vs_azure_7B73CA32.png' class='blogimage img-responsive'>

I’m working on a project which has as one of its goals the “publishing” of some very large datasets (order of 1PB) to the “cloud” for consumption by the general populous for use in scientific research. Rather than designing/inventing our own API, our decision has been to provide an interface consistent with the APIs produced by some of the leading cloud storage providers. Our goal would be that if someone is already used to/has tooling to working with cloud data sources such as Amazon’s S3 service or Microsoft’s Azure Blob storage, those same tools/experiences should directly apply by simply changing the http endpoint.

Unfortunately, neither Amazon or Microsoft seem poised to provide an open source implementation of their interfaces (from a service host perspective) so we are faced with the challenge of reverse-engineering their server-side interfaces. Neither is overly complex, so this certainly isn’t rocket science, but as I’ve been digging/poking at them the last few days I’ve found myself wishing there was more commonality between them. There are certainly many similarities and the “lift” moving between them is not heavy, but that’s actually the rub… they are so similar in many ways that I find myself wondering why they aren’t identical… are the deltas actually adding any value, or are they simply the repercussions of different groups of people solving the same problem while trying to convince the world they are not copying one another. I should be clear that I’ve been focused on the REST APIs and haven’t spent any time with the SOAP interfaces so I can’t speak to the commonality or lack thereof at that level.

From a client perspective, they are similar enough that there are many tools (both OSS and commercial) that can front-end either platform, so the differences aren’t *that* significant. John Spurlock has done some good work in providing some libraries for C# that provide wrappers for the REST APIs and a [client application](http://www.codeplex.com/spaceblock) and its [foundation](http://www.codeplex.com/resourceful). and Alin Irimie has assembled a simple [chart illustrating some of the similarities](http://www.azurejournal.com/2008/11/amazon-s3-vs-azure-data-storage/).
