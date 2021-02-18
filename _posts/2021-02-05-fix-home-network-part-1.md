---
category: technology
title: 'Fixing My Home Network: Part 1'
date: 2021-02-05 08:00
tags:
- networking
- wifi
description: "I have a tendency to over-think things. I like to imagine that it is a personality feature rather than a blight, but some close to me may not always agree. Regardless, I have recently turned my focus towards fixing my home network and, in typical fashion, I have spent what is quite likely far too much time and exerted far more effort than the problem warranted. That said, I have arrived at, what I hope, will be a quite stable and well-performing network for quite some time to come. In this series of posts, I detail the starting point, the analysis I applied, the changes I have made, and the final results"
---

I have a tendency to over-think things. I like to imagine that it is a personality feature rather than a blight, but some close to me may not always agree. Regardless, I have recently turned my focus towards fixing my home network and, in typical fashion, I have spent what is quite likely far too much time and exerted far more effort than the problem warranted. That said, I have arrived at, what I hope, will be a quite stable and well-performing network for quite some time to come. In this series of posts, I detail the starting point, the analysis I applied, the changes I have made, and the final results. As with most things, your mileage may vary, but maybe you will find the following helpful, or at least mildly entertaining.

The posts in this series are as follows:

* [Part 1: Introduction and background (this post)]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/)
* [Part 2: Establishing an RF baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/)
* [Part 3: Internal Network Baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/18/fix-home-network-part-3/)
* Part 4: External Network Baseline
* Part 5: Selecting the New Eqiuipment
* Part 6: Deploying the New Equipment
* Part 7: Resulting RF Baseline
* Part 8: New Internal/External Network Measurements
* Part 9: Comparison and Initial Results
* Part 10: One-Year Later

I know you are probably already exhausted, but let's get started.

## Background

I should start off by providing some context. I live in a two-story, mid/large home that covers approximately 3,700 square feet. We are a family of six and between all of us (personal, work, school, IoT, etc.) we have over 70 network-connected devices. My wife works from home (telecommutes) and I do a portion of my work from my home office. With COVID and the setup with our local schools, the four kids (spanning elementary through high school) are mostly in-person but have had some "red" days wherein everyone participates in virtual learning. Given all of this, having a network (both wired and wireless) that performs consistently well is important to us. 

Additionally, we have been cord-cutters for over six years so any of the television we watch is grabbed either over the air or streamed. We also have a mostly-legacy movie collection that is hosted on a private PLEX server so cross-network performance is important. We use both local shared file storage and cloud storage for backup and redundancy. While some of our music collection is on the PLEX server, in reality it is almost all streamed down from cloud providers.

Our Internet connection is provided by AT&T and we pay for 1Gbps service (fiber to the home). I should start by saying that, while the service is supposedly rated at 1Gbps, I've never seen performance over more than about 500 Mbps on any test (I have a theory as to why... more on that below). 

## Network Layout

I wil be the first to admit it is quite likely that many of my network troubles are of my own making. If we were a _normal_ family with _normal_ network use cases, most (maybe all) of these issues would go away... but here we are.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/homenetworkstart.png"><img src="{{ site.url }}{{ site.baseurl }}/images/homenetworkstart.png" alt="Initial home network layout"></a>
  <figcaption>Initial home network layout</figcaption>
</figure> 


The layout above is mostly self-explanatory, but there are a few things that bear calling out:

__AT&T Router/WiFi:__ I hate this device, and I don't like the fact that I have to have it. According to the installation/service tech, it is required and there's no alternative. I have, however, configured it so that it is as "non existent" as possible. Meaning, it is a direct pass-through and also has all of its WiFi radios disabled. It *does* still perform network address translation and it is my theory that this device is underpowered and unable to route/pass gigabit-speed traffic. I would place bets on the fact that if I could eliminate this device, my overall network performance (with respect to the Internet) would greatly improve. 

__Netgear ORBI:__ This is my main network router and WiFi. If you know anything about this router, you know it is normally paired with one or more "satellites" that provide mesh networking to cover your whole home. In the past, I have had two such satellites that were connected to the router via Ethernet backbone (1Gbps), but I had no end of trouble with network reliability. _Signal_ was always good, but throughput was spotty... devices would seem to lose their head, no longer have traffic passed, forget how they were supposed to communicate, etc. It seems like a great idea, but it never quite worked reliably for me. I found that disconnecting the two satellites provided much higher reliability even though signal strength suffered.

__Netgear Nighthawk R7000:__ This is probably the most "odd" thing on the network and may be the source of numerous issues. Being the parent of kids learning to use devices and the Internet is a difficult balance of teaching, responsibility, and controls. The primary means we have handled this over the years is using [Circle by Disney](https://meetcircle.com/). This allows us to assign each device (via MAC address) to a person/profile and then set filters, time restrictions, etc. for each child. While this works generally well and is quite user-friendly, the implementation makes my network-purist-wannabe *skin crawl*. In its primary form factor - an appliance you simply plug into your network - it ARP spoofs *every* device on the network to allow itself to man-in-the-middle (MITM) all of your traffic. This works reasonably well with a handful of devices, but some of my systems didn't like it at all. My distaste for the implementation was resolved when Netgear started offering Circle as an integrated option into some of their routers. This was great... the filter was implemented at the natural/existing gateway to the devices and no longer required ARP spoofing or layer 2 funny business. Unfortunately, while some earlier-generation ORBI devices came with Circle support, the RBR750 *did not* (much to my disappointement). To make matters worse, connecting the appliance-based version really made the network unstable. I'm not certain if the layer 2 schennanigans were messing with ORBI's mesh networking or traffic direction logic, but things were not going well. Therefore, my (admitedly ugly) _"solution"_ was to re-deploy an old R7000 I had sitting around that still had Circle support built in. I then connected all of my kids devices to that access point and thereby limited any ill-effects to that segment.

<figure class="align-center" style="width: 400px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/circle.jpg"><img src="{{ site.url }}{{ site.baseurl }}/images/circle.jpg" alt="Disney Circle"></a>
  <figcaption>Circle by Disney for Parental Controls</figcaption>
</figure> 

## Obvious Issues

It woudn't take anyone very long to look at this layout and make some obvious changes. All of my main network traffic is double-NATed due to the required AT&T router. Making things worse, traffic from the kids network is _triple_ NAT'd which is more than sub-optimal. 

Making things worse, I have two wireless access points, literally feet from each other, fighting with each other in both the 2.4 and 5 GHz RF bands. I did (or thought I had) configured things so that they used different channels, thereby mitigating some of this.

## Known Issues

Besides the problems I was causing myself, and the general network stability issues I referred to earlier, there were at least three places within the house where network connectivity was particularly bad.

1. The first location is our sunroom, which generally doesn't matter but has become a logical favorite during the pandemic as a place for one of the kids to do virtual school. Invariably, whoever sat in there would have consistent connection issues.

1. The second problem area is one of the kids bedrooms. This is directly above the sunroom, so the distance from the AP is similar. In general, this woudn't be an issue as the kids don't have devices in their rooms beyond a network connected speaker for listening to music. However, on the far side of this room I have a wireless wetherstation mounted to the roof and also have a wireless security camera. Both of those regularly struggle with connectivity.

1. The last issue is in my garage. I have a home gym in there and regularly stream workout content there. Additionally, I have a network-connected indoor garden controller that monitors and automatically waters our herbs and vegetables. This area has also had consistent issues.

## Additional Motivation

One last thing before we get rolling... I should be up-front about another driving motiviation behind this work. I am part of a church plant in my area and we are currently leasing a few buildings and looking to build in the next few years. I'm looking at the approaches and equipment here to help inform what we may (or may not) use to managed and deploy networking kit across those facilities. One key to this is being solid and supportable by those who have full time jobs that don't involve making sure the church WiFi is working. Here, reliability is a key.

## Next Steps

[In the next post]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/), I analyze the RF network coverage to attempt to understand some of the issues and to confirm that what I experienced (or thought I was) could be confirmed by emperical measurements.
