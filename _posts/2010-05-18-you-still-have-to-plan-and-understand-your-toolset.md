---
category: technology
title: 'You Still Have to Plan and Understand Your Toolset'
date: 2010-05-18 00:00
tags:
- cloud
- theory
- aws
- azure
redirect_from:
- /blog/2010/5/18/you-still-have-to-plan-and-understand-your-toolset.html
---
I just finished [reading an article](http://searchcloudcomputing.techtarget.com/news/article/0,289142,sid201_gci1512394,00.html) discussing some of the power issues and related outages at one of [Amazon’s](http://aws.amazon.com) data centers last week. While much of the article was fine and factual, I take a bit of issue with the way the article wraps up:

> Users may not like being told they should fend for themselves on disaster preparedness, but that appears to be part of the price for getting everything else AWS offers.

This highlights a sentiment that is unfortunately pervasive within the community of those evaluating or adopting cloud computing – that of believing that cloud computing is a panacea for all scale and datacenter problems.

What the users of these platforms need to understand is that they are toolkits. While the various cloud computing vendors provide important services and features, the consumer of said platforms must do their homework to understand the technical tradeoffs of various decisions so that they can appropriately reap the benefits of the selected platform. Simply uploading your code/application and expecting it to be always available is unrealistic. The consumer must understand what high availability features are offered by their particular cloud vendor and exploit those features to ensure that their app has the appropriate availability. In the case of the Amazon outage(s), if users had followed the high-availability guidelines provided by Amazon, they would not have experienced any outage at all. Cloud providers such as Microsoft, Amazon, and others provide the notion of availability zones, or regions, and – much like you would if you were hosting the app yourself – you need to distribute your application across such to ensure that a failure in one location doesn’t mean a complete outage for your application.

Rather than a magic wand that solves all scaling and availability issues, cloud computing provides a democratized toolset that informed consumers can use to develop a highly available, scalable, and fault-tolerant application. The key word here is “democratized” – meaning – these features are available to anyone, at a fraction of the cost of doing it yourself. I experience similar frustration when reading complaints from folks about the pricing of Windows Azure (i.e. “Why can’t I host my simple website there fore $10/month?”). The question illustrates that the inquirer doesn’t understand the fundamental architecture of the platform (both how it works, and what its primary use cases are). Neither Amazon’s EC2 nor Windows Azure are designed to compete with a low-cost web hoster… rather they are designed to provide the tools by which a company that needs features not available from a low-cost hoster, but doesn’t have (or wish to spend) the capital to build those features themselves.

They are great platforms that provide you the ability to build a very solid offering, but you have to understand how to properly utilize those features. Cloud computing should not be approached with ignorance or any less planning than you would if you were building out the infrastructure yourself (of course the level of detail will differ).
