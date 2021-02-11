---
category: technology
title: 'Thinking the Cloud…'
date: 2008-07-18 00:00
tags:
- cloud
- cloud computing
- theory
redirect_from:
- /blog/2008/7/18/thinking-the-cloud.html
---
I’ve been talking quite a bit with a co-worker about “the cloud” and how organizations can and will leverage it over time, and how application development/design may change as a result. Microsoft’s Sql Server Data Services (SSDS) is only one example of a major paradigm shift in the industry away from internal-only systems to treating certain things as commodity-style resources.

I’ve been thinking through a problem for a non-profit that I work with wherein they needed to share approximately 7.5 GB worth of corporate documents amongst a geographically dispersed team. We’ve been facilitating this by using a WSS site hosted on a little box at my house for the last year or so, but have had increasing frustration with normal home-hosted issues (power blinks, server goes off while I’m out of town, etc.) so I’ve been researching how to solve this problem inexpensively but also well enough to “make the problem go away”. Because of the other discussions my co-worker and I have been having recently, I naturally looked for a “cloud-based” solution.

Here’s the list of things I reviewed:

* [Microsoft Office Live Small Business](http://www.officelive.com) – this looked to be a very interesting option… you sign up, get some custom domain mail accounts, a little website if you’d like, and some private space which is essentially a highly-tailored/restricted WSS platform. $15/month for 5GB of space. I contacted their helpline, they assured me I could add to that to meet my 7.5 GB requirement so I started uploading… after 4.9 GB (and a LOT of time – my poor cable modem…) I went to add another 5GB only to have the control panel deny me that option. Another call to customer service and the nice-but-feature-ignorant customer service representative told me “I sure thought you could do that but I guess not”. Cancelled the account and threw away the upload time… oh well… (UPDATE: I’ve since been called back by another rep who assured me that it was, in fact, possible and that all would be well, but the ship has sailed…)
* [Microsoft Office Online](http://www.officeonline.com) – this is the full-blown version of Hosted SharePoint… would have been great however it is currently in beta and has no prices listed. Based on the target audience and the pricing for their hosted live meeting service, my gut tells me it is going to be too pricey for the non-profit to swallow so I moved on…
*  SkyDrive – this would be great… it’s exactly what I needed… but I need 7.5 GB… not 5… I couldn’t find any way (even offering to pay) to get more than 5 GB… on to other options…
* __Insert your favorite file share here__: Found a bunch of services that might work… some of which I had heard of before, others I wasn’t sure of, some looked too good to be true, some I wasn’t convinced would be around long enough for me to get my data uploaded much less 4-5 years from now…

Then, a friend recommended I look at Amazon S3 and I’m pretty glad he did. Amazon offers “Object Storage” in the cloud for very cheap prices… and expose a series of XML Web Services to interact with the service. It takes almost nothing to get setup, and there’s a number of code samples available on [CodePlex](http://codeplex.com) to illustrate working with it. I’m currently playing with a share-ware tool called BucketExplorer (~$50) that works as a file client for the service and, besides being a resource hog, is workign fairly well. The best part about this solution is that it is incredibly cheap ($0.15/GB/Month!) and I can integrate it directly into our existing admin control panel without the staff knowing that the actual data “lives someplace else”. The Internet storage has become a commodity – something that I can just assume is available… pretty slick if you ask me.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/image_2.png"><img src="{{ site.url }}{{ site.baseurl }}/images/image_2.png" alt="Amazon Pricing"></a>
</figure>
