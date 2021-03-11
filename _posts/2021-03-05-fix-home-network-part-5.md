---
category: technology
title: 'Fixing My Home Network: Part 5'
date: 2021-03-05 08:00
tags:
- homenetwork
- networking
- wifi
- ubiquiti
excerpt: "Over the past few weeks, I've been writing a series of posts on how I evaluated the state of my home network, updated it, and then measured the changes. This post and the next represent the mid-point or hinge of the series. Here I discuss the equipment I selected and the rationale for the selections. In the next post, I'll discuss the actual installation and configuration of the devices."
toc: True
---

Over the past few weeks, I've been writing a series of posts on how I evaluated the state of my home network, updated it, and then measured the changes. This post and the next represent the mid-point or hinge of the series. Here I discuss the equipment I selected and the rationale for the selections. In the next post, I'll discuss the actual installation and configuration of the devices.

The [posts in this series]({{ site.url }}{{ site.baseurl }}/tags/homenetwork/) are as follows:

* [Part 1: Introduction and background]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/)
* [Part 2: Establishing an RF baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/)
* [Part 3: Internal Network Baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/18/fix-home-network-part-3/)
* [Part 4: External Network Baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/24/fix-home-network-part-4/)
* [Part 5: Selecting the New Eqiuipment (this post)]({{ site.url }}{{ site.baseurl }}/technology/2021/03/05/fix-home-network-part-5/)
* Part 6: Deploying the New Equipment
* Part 7: Resulting RF Baseline
* Part 8: New Internal/External Network Measurements
* Part 9: Comparison and Initial Results
* Part 10: One-Year Later

## Requirements

If you've been following along in the series, you'll understand a number of the requirements I have for my network, but I thought it might be helpful to list them clearly here:

* __Good network coverage throughout the entire house__. This is mostly a no-brainer... I want it to _"just work"_, no matter where I am (within reason). I don't care if it doesn't work well in the closet, but it should when I'm in my office, or if we are on the couch watching TV, or when the kids are doing schoolwork. Additionally, I have some remote (edges of the roofline) sensors for weather and home security that need coverage.
* __Support for multiple wireless networks__. This may not be for everyone, but I like to separate my devices by trust zones. I have four main networks - our primary network where all of our trusted items live, our kids network which is similar to the primary, but uses Circle by Disney for parental controls, the IoT network where I trust nothing, and the guest network where I trust no one. Being able to support this level of segmentation _without_ requiring a ton of extra/redundant hardware would be great.
* __Network-level isolation between those networks__ (e.g. primary, IoT, kids, etc.). Multiple networks doesn't help you if they all get dumped onto the same Ethernet segment at the switch/router level. I'd like the system to support isolation from the AP all the way to the firewall. For those network savvy of you, this is most often implemented via VLANs.
* __Ability to avoid the "swamping" problem__ (one client starts massive file download, everyone else is held up until it finishes). One issue we had regularly with the previous configuration is that if someone (generally me) started a large file download, I would soon hear from others in the house that their connections were offline. They weren't really, but it seemed as if some component in the pipeline wouldn't service anyone else until my request was complete. In reality, I'd just as soon have my download slowed a little if the network would continue to service everyone else, but I didn't see a way to accomplish that. The goal here, is to provide consistent performance to all clients, rather than possibly amazing performance to one at the cost of making others wait.
* __Ability to fully utilize the Internet connection I have__. As silly as it sounds, I realized that I had a 1 Gbps internet connection but the router I had couldn't support routing traffic at that rate. Yes, it had a Gbps jack, but the processing power and software configuration simply couldn't keep up. It only makes sense to me to select equipment that isn't throwing away network speed.

## Selection

I did a good bit of research looking at various mesh networking options, gaming routers, professional equipment, etc. In the end, I selected equipment from the [Unifi Dream Machine](https://unifi-network.ui.com/dreammachine) and related line of products made by [Ubiquiti](https://www.ui.com/).

**NOTICE:** I want to clarify that this is _not_ a sponsored post. While researching this topic, I came across a number of articles and, particularly prevelant, YouTube videos that were assembled by folks who had been sent evaluation or otherwise subsidised equipment from Ubiquiti. I have not, nor do I expect to, receive any remuneration for this post. There is, of course, nothing wrong with those posts (given proper disclosures).  
{: .notice--info}

### Rationale

The line between consumer, prosumer, and professional often gets blurred. In our case we have six people in the home, both my wife and I regularly work from home, the kids often do school from home and we have over 70 connected devices. We need the network to *just work*. Because of this, I'm willing to invest a bit more in something I can configure, set, and know it will be up to snuff for the next five years. That said, pro-line/commercial networking gear gets crazy expensive crazy fast - *easily* north of $1,000 for a single switch. The research I did, reviews I read, etc. gave me a reasonable level of confidence that I would be pleased with my selection of the Ubiquiti kit. The equipment is well built, the sofware is well-designed, and the price-point, while higher than Linksys/NetGear, is well below that of true commercial gear.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/dmp_controller.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/dmp_controller.png" alt="Dream Machine Pro Dashboard"></a>
  <figcaption>Dashboard on the Dream Machine Pro</figcaption>
</figure> 

Looking into things a bit further, the management tools and controls were specifically enticing to the data/control nerd in me. All of the features I was looking for - VLANs, multiple independent wireless networks, solid, configurable firewall, high-throughput/backbone, etc. were avilable. Some features I didn't expect but was pleased to find included deep-packet inspection/reporting, integrated VPN server, utilization and speed testing, RF environment assay and more. These figures give a little idea of some of the tools and control available within the Unifi Controller.

<figure class="align-center" style="width: 397px">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/mainfloor_ap.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/mainfloor_ap.png" alt="AP utilization"></a>
  <figcaption>Utilization details for one of my APs</figcaption>
</figure> 


### Parts Selection

* __Unifi Dream Machine Pro__ - This is the "brains" of the system. It provides the core network controller (software-defined-networking interface), the firewall, and the intrusion detection/prevention system. Additionally, it serves as a NVR (network video recorder) if you are using the Ubiquiti IP cameras and can also provide physical access control and phone support (most applicable to small business environments). The biggest reason I selected this unit over the non-pro version, was that it is equipped to support the full 1 Gbps line rate of my Internet connection. Even with the IDS features enabled, it is rated for a throughput of about 3.5 Gbps. By contrast, the Dream Machine has a 850 Mbps rated throughput.
* __Unifi Switch 24 PoE__ - This is the Ethernet backbone for my network. If I had better (more pervasive) CAT6 cabling thorughout my house, this would be the only switch listed. All of the others exist simply because of port/cabling limitations. Notice that this is *not* the Pro version. The biggest advantage to the Pro edition is that it has 10 Gbps SFP ports for the uplink to the DMP. In my use case, this feature simply didn't justify a doubling of the price of the switch. An additional positive for the non-pro version is that it is fanless, reducing the noise in our network closet.
* __UniFi Switch Light 16 PoE__ - This switch is mounted on the desk in my office and provides hard-wired connectivity for a number of the devices I have there. On any given day, I have a couple of computers and a stack of six Raspberry Pis connected. At this time, none of these devices are PoE, but having a few powered ports available is a nice feature.
* __USW Flex Mini 5-port Managed Switch__ - This is a simple little switch that lives in my media cabinet and provides network ports for the hardwired devices there. None of them need PoE, so this switch does a great job at a crazy good price point. It is powered by PoE from the main switch further reducing the number of cables and complexity in my media cabinet.
* __UniFi Switch Light 8 PoE__ - This switch lives in the attic in the Garage and serves as an uplink/downlink to the main attic as well as providing PoE and Ethernet to the two cameras I'm testing and the access point in the garage. If I had more home runs to the main switch, I wouldn't be using this at all. This switch is powered via *normal wall power* and provides PoE to the connected devices.
* __UniFi Switch Flex__ - This switch lives in the main attic and is connected through the switch in the garage attic back to the main switch (*groan*). This double-hop is required only because of the lack of foreknowledge I had when we built the house five years ago (why would I ever need Ethernet in the attic?). This is a 5-port PoE-powered switch quite similar to the Flex Mini above, however it can also *source* PoE to its connected devices. This supports the access point on the second floor and provides hard-wired connectivity to our home-made weather station on the roof.
* __UniFi nanoHD Access Point__ - I actually have three of these. One is located in the main kitchen/living room area, one in the center of the second floor bedrooms, and one on the ceiling of the garage. Together they provide the primary coverage to the house for WiFi. I specifically selected these because of the radio capabilities: 4x4 Multi-User MIMO on the 5 GHz band as well as the 2x2 MIMO at the 2.4 GHz band. They are *not* WiFi 6 capable... in my reading, I'm not certain the WiFi 6 standard has stabilized enough both in form and function. Additionally, I do not have any WiFi 6 enabled devices. 
* __UniFi In-Wall HD Access Point__ - I have two of these deployed to "fill in" some connectivity where the main APs didn't quite cover. One is in my office and another is in the sitting room in the master bedroom. This device has the same radio capabilities as the nanoHD, but also includes a 4-port switch discretely contained in the bottom of the wall plate. In both use cases, this is quite helpful as I wanted both some additional WiFi coverage, but needed a few ports available for co-located hard-wired devices. 


**Buyers Notice:** There are a number of places you can purchase Ubiquiti equipment. This includes network gear resellers, various online outfitters, and even directly from Ubiquiti themselves. I did find that, while most all of the equipment was available for order directly from Amazon, the prices were significantly higher. While their shipping and delivery options might be interesting, take the time to do some homework and you might find plenty of savings available.
{: .notice--warning}

## Installation

In my next post, I'll discuss the installation and configuration of the new network and provide some initial impressions before measuring the effective differences.
