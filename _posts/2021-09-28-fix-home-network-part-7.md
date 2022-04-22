---
category: technology
title: 'Fixing My Home Network: Part 7'
date: 2021-09-28 08:00
tags:
- homenetwork
- networking
- wifi
- ubiquiti
- nextdns
excerpt: "Over the past few weeks, I've been writing a series of posts on how I evaluated the state of my home network, updated it, and then measured the changes. This post and the next represent the mid-point or hinge of the series. Here I discuss the equipment I selected and the rationale for the selections. In the next post, I'll discuss the actual installation and configuration of the devices."
toc: True
published: false
gallery:
  - url: /assets/images/hn_config06.png
    image_path: /assets/images/hn_config06.png
    title: "2.4 GHz Scan"
  - url: /assets/images/hn_config07.png
    image_path: /assets/images/hn_config07.png
    title: "5 GHz Scan"
---

Way back in [part 2 of this series]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/), we looked at taking an initial RF scan of the network _prior_ to making any changes with the intent that we could do the same after the upgrade and compare/contrast the results. In this post (part 7), we look at the RF performance of the network now that the new equipment has been installed.

The [posts in this series]({{ site.url }}{{ site.baseurl }}/tags/homenetwork/) are as follows:

* [Part 1: Introduction and background]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/)
* [Part 2: Establishing an RF baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/)
* [Part 3: Internal Network Baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/18/fix-home-network-part-3/)
* [Part 4: External Network Baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/24/fix-home-network-part-4/)
* [Part 5: Selecting the New Eqiuipment]({{ site.url }}{{ site.baseurl }}/technology/2021/03/05/fix-home-network-part-5/)
* [Part 6: Deploying the New Equipment]({{ site.url }}{{ site.baseurl }}/technology/2021/03/17/fix-home-network-part-6/)
* [Part 7: Resulting RF Baseline (this post)]({{ site.url }}{{ site.baseurl }}/technology/2021/09/28/fix-home-network-part-7/)
* Part 8: New Internal/External Network Measurements
* Part 9: Comparison and Initial Results
* Part 10: One-Year Later

In part 2, I described the rationale behind my tool selection and provided a brief description of NetSpot. Additionally, I determined then that it would be a little weird for me to post accurate drawings of the inside of my house, so I used a different building. In this post, I'm going to discuss the improvements (RF-wise) in my house and provide a couple of cropped images to demonstrate the changes.   

## Networks / VLANs

One of my objectives in this project is to provide clear segmentation as part of my organization and security of my network. I began by defining four individual networks as shown in the figure below:

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config01.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config01.png" alt="AP utilization"></a>
  <figcaption>Network Definitions</figcaption>
</figure>

Other than the `LAN` network, each of these were given their own VLAN tag and configured such that they were isolated networks. Configuring DHCP and content filtering for each network is straight-forward in the UI. The purpose of each network should be easily deduced from the name. __IOT__ is where I put anything that I don't trust. __VPN__ is for remote clients (normally just me). __Students__ is where my kids and all of their devices go and has the additional content filter enabled. Finally, __LAN__ gets everything else. 

I should note that, because the __Students__ network has its own VLAN, I can deploy the [Circle by Disney](https://meetcircle.com/) (_parental controls_) device I discussed in the [first post]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/) and not need to worry about it ARP-spoofing every device on the network. Its range of influence is limited to the devices it should manage and the rest of the network operates without knowing it is even there.

## Firewall

With the networks configured, I then went through and set up the firewall to isolate the networks as desired while still letting a few services through. We often consider firewalls to block/protect at the border, but this lets me establish _walls_ between devices sitting on the same desk based on the use case and trust level. Again, rather than describing each rule in detail, I'll simply provide the following image as the rule names should communicate what each does:

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config02.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config02.png" alt="Firewall Rules"></a>
  <figcaption>Internal Firewall Rules</figcaption>
</figure>

You'll notice that shown in this figure is the _LAN_ tab. The _Inernet_ tab contains the border rules, and you can set additional rules based on the boundaries defined using the other tabs.

## Wireless Network

With the basic communication layer configured, I moved on to set up the wireless network. In the figure below, you'll see the individual SSIDs defined. As you might imagine, each SSID is mapped to the appropriate network defined above and traffic from each is tagged with the matching VLAN IDs.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config03.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config03.png" alt="WiFi Networks"></a>
  <figcaption>WiFi Network Definitions</figcaption>
</figure>

One of the nice features of this system is that I'm able to define as many networks as I'd like, and have them broadcast using the same/non-competing radio hardware. This gives me a great deal of flexibility without adding all sorts of unnecessary RF-level interference. Further, while not really something I needed, you can assign certain SSIDs to specific APs. You may want to do this if you have a fixed-position device that you always want to connect to a particular AP and _not_ have it roam. I have not yet needed this, so I'm letting each of my APs broadcast all four networks.

**ProTip:** Actually, there is a limit to the number of SSIDs each of these APs can broadcast. For the hardware I have deployed, that number is __8__, which is _plenty_. If you need more than that, be sure to check the specifications of the APs you utilize.
{: .notice--info}

### Channels, Bandwidth, Strength

I need to admit that this is probably the one place that the changes made the most difference. In my previous setup, I let the AP pick a channel for both the 2.4 and 5 GHz radios. Next, it asked me what speed/data rate I wanted to configure them for and, because I assumed faster is better and didn't take the time to understand the tradeoffs, I picked the fastest option for each. Some of you know where this is heading... One of the ways to increase your speed (physical-layer maximum data transfer rate) is to increase the bandwidth available for your selected channel. The _problem_ with this, is that as you increase your bandwidth, you also increase the liklihood for interference as you are now stomping on the spectrum normally reserved for other channels. The following figure from [Network Computing](https://www.networkcomputing.com/wireless-infrastructure/dynamic-frequency-selection-part-3-channel-dilemma) illustrates the affects that different channel widths (y-axis) have on the number of distinctly-available channels.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/graphic-80211-acChannels-all.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/graphic-80211-acChannels-all.png" alt="Channel Width vs Count"></a>
  <figcaption>Channel Width vs Count</figcaption>
</figure>

Here you see that if I select a 40 MHz channel, I'm essentially using two 20 MHz channels. Similarly, a 160 MHz channel consumes a total of __8__ 20 MHz channels. The same scenario applies to the 2.4 GHz band.

While this may not matter at all to you if you are setting up a wireless network in your country estate that is isolated from your nearest neighbor by 10 acres of forrest, in a subdivision like mine, with postage-stamp-sized lots, it really matters.

The practical implications are relatively obvious. In order to get the *best* performance, I should really coordinate with all of my neighbors, and we should each select a reasonably-wide channel that does not overlap with those within range of our respective APs. You could imagine a scenario where house A uses channel 1 at the 2.4 GHZ band, B uses channel 6, C uses 11, D uses 1, etc. (yes, this gets a little messier when you think about the houses behind or across the street from you). 

Another ramification of this, is that setting my channel widths lower, may _reduce my maximum observed wifi throughput_. The tradeoff, of course, is that my _reliability_ (lack of interference) will likely increase and I will likely have a more consistent experience.

From within the controller software, I can connect to an individual AP and perform a scan of the RF environment and attempt to make my own decisions as to the optimal configuration for my location and setup. The following shows the results of a scan from the AP in my garage.

{% include gallery caption="RF Environment for Garage AP" %}

Here you may realize that you could spend a somewhat endless amount of time taking measurements, negotiating with your neighbors, adjusting settings, etc. All this and we haven't even disucssed the impact of individual radio transmit power... Thankfully, there is an option in the Unifi controller to provide some assistance.

**Warning:** In my research of this topic, this appears to be a somewhat controversial feature. Some don't like the notion of devices being reconfigured without their involvement. Others have seen stability issues from clients that don't like the physical layer changed on them. My experience to date has been positive, but your mileage may vary.
{: .notice--warning}

The Unifi Controller has a capability called __WiFi AI__ (of course it is) that aims to automate most of this. What it does, is (by default) once per day, it looks at your APs, looks at the RF environment around each, and then makes a determination as to whether or not the channels need to be changed, or the power needs to be increased or decreased, or whatever. If it finds an issue, it will make that change and you should never need to think abou it. In recent versions of the controller software, they log this activity so you can see the changes as shown in the figure below. 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config04.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config04.png" alt="WiFi AI"></a>
  <figcaption>WiFi AI</figcaption>
</figure>

So far, I have let the system automatically configure itself and performance (experientially) has been pretty decent (will valiate in subsequent measurements). As of this writing, my APs are using channels `1` and `6` in the `2.4 GHz` band with channel widths of `20 MHz`. At `5 GHz`, they are using channels `38`, `151`, and `159` and are configured for a `40 MHz` channel width. Each has slightly different transmit power settings. I like that it is not limited to a single configuration that is then applied to all of the APs, but considers the RF environment of each and tunes the settings appropriately.

### Captive Portal

This could almost go under the "extras" section, but it is a core feature of the platform, so I'll list it here. The Guest Network functionality in the DMP is much more along the lines of what you would expect in a "professional" guest network (is that a thing?). When you connect, you are presented with a captive portal/sign in page that you can configure. In my case, I'm glad to have a guest network, but I like the idea of it being used only by people who know me (not my neighbor's guests). The easiest way to enforce this is to use a simple password that can be easily entered by those who know it. A few selections make this easy to implement as shown in the figure below. This is otherwise a non-customized screen. I've seen some captive portals that are heavily customized - you can easily go overboard.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config09.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config09.png" alt="Guest Network Captive Portal"></a>
  <figcaption>Guest Network Captive Portal</figcaption>
</figure>


## Extras

The following items are not necessarily requirements, but are nice features, or _extras_ that come along with having a higher-end network controller. Things that simply make operation of the network a bit better.

### NextDNS

Another change to my security posture is to utilize a trusted DNS resolver such as [NextDNS](https://nextdns.io/). They provide direct integration for the Dream Machine so all I needed to do was to SSH into the device, run their script, configure a few things, and suddenly all of my network devices can benefit from the configuration and threat blocking options of their service. 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config08.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config08.png" alt="NextDNS on DMP"></a>
  <figcaption>Configuring NextDNS on Dream Machine Pro via SSH</figcaption>
</figure>

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config05.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config05.png" alt="NextDNS"></a>
  <figcaption>NextDNS</figcaption>
</figure>

Not only does NextDNS let me block malware and tracking domains, but it also provides visibility into what devices are making what queries. This allows me to easily troubleshoot issues if I am seeing a high number of blocked queries from a particular device or set of devices.

### VPN

There's not much to say here other than that it has an in-built L2TP VPN server that works. With just a little configuration I was able to set things up so I can securely connect into my network from anywhere. I know many devices do this, and I've tried some of them, but I've never really gotten it to work with anything other than pfsense.

### WiFiMan

WiFi Man is a utility that has existed for a few years as both an [iOS](https://apps.apple.com/us/app/id1385561119) and [Android](https://play.google.com/store/apps/details?id=com.ubnt.usurvey&hl=US) application. You do not need to have a dream machine to use the application, but due to some improvements in recent versions of the firmware, if you *do*, things get a little more interesting. The app will automatically detect the DMP as a "WiFi Man Test Server" and enable some handy features. From the application side, I can learn a decent amount about my current connection simply by opening the app, and get a dynamically-updated signal strenth monitor which can be helpful as I'm walking around testing realized connectivity speeds. 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config11.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config11.png" alt="WiFi Man"></a>
  <figcaption>WiFi Man</figcaption>
</figure>

Additionally, it allows me to run `iperf3`-style speed tests across the network and keeps a log of my historical tests.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config10.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config10.png" alt="WiFi Man Speed Test"></a>
  <figcaption>WiFi Man Speed Test</figcaption>
</figure>

On the server / controller side, I can see the results from each device that has run a speed test.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config12.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config12.png" alt="WiFi Man Speed Test Log"></a>
  <figcaption>WiFi Man Speed Test Log</figcaption>
</figure>

### Topology View

Some might this this is a bit of a gimmic, but I have used it more than I would have expected. One of the side effects of a full software-defined networking layer, is that the controller knows where everything is, all of the time. This allows it to render (and maintain) a topology graph like the following. This is helpful in troubleshooting various connections and understanding how things are connected and why they may be performing in a certain fashion.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config13.png"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/hn_config13.png" alt="Network Topology"></a>
  <figcaption>Network Topology</figcaption>
</figure>

### Aesthetics

The way things work/perform is often more important than how they look... _but_ when they can look good as well, it is always helpful. I wanted to include two pictures that convey a bit of how this system looks as deployed. The first is a picture of the in-wall HD AP. This is powered by POE and has a 4-port switch in the bottom of it. This is mounted on the wall in my home office and looks great.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/office_ap.jpg"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/office_ap.jpg" alt="In Wall HD"></a>
  <figcaption>In-Wall HD</figcaption>
</figure>

The second is the Nano HD mounted on the ceiling in our second-floor hallway. It blends in rather well and is about the size of a smoke detector. I've disabled the status LEDs, so they don't glow or otherwise draw attention to themselves. 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/assets/images/upstairs_ap.jpg"><img src="{{ site.url }}{{ site.baseurl }}/assets/images/upstairs_ap.jpg" alt="Nano HD Ceiling Mount"></a>
  <figcaption>Nano HD, Ceiling Mount</figcaption>
</figure>

## Gotchas

I'll be quick to say that, while things have been quite amazing in general, there have been a handful of oddities that have arisen. 

### Firmware Updates

This seems to be the weak link in the process. Each time there is a firmware update (there have been two since I deployed this setup about a month ago), there have been issues with the system's stability. During the first one, I had (mistakenly) left the _Automatically update all firmware on all devices_ setting enabled and... it tried... and _mostly_ succeeded. I had one device (an AP) lose its head and fail to be adopted (their term for being added to the controller and managed by it). I had to SSH into the AP (somewhat cool that you can do this) and reset it. I then re-added it and re-configured it and everything has been fine.

### Inconsistent Experience

This post is delayed due to this very issue... I updated the firmware the day prior, and suddenly all of my remote access is gone. This includes after having updated to the latest version of the apps and/or browser refresh. This may not be an issue for some, but being able to know that my network was humming along nicely for my wife and kids working at/doing school at home is one of the reasons I'm in favor of this type of system.

**Update:** This falls into the category of "if it doesn't work, try rebooting it". I had updated the firmware on the controller as well as the software for the networking "application". While the service _restarted_, it had not been _rebooted_. A simple/clean reboot of the controller got everything happy and running again.
{: .notice--info}

Another issue is that at various points they (Ubiquiti) seem to want to push you automatically to the 'alpha' or 'beta' versions of their softare (controller will default to the 'alpha' version of the user interface). Unfortunately, this sometimes means that features you are used to (e.g. speed test stats graphs) suddenly disappear as they did recently (`6.1.61`). I'm hopefull that they will come back, but there's no guarantee of this. 

## Helpful Links

While performing the work described here, I often referenced some posts by others and some relatively helpful videos. The following links may be of use for someone considering a similar setup or just wanting to learn more. I should also mention that I found many posts that were less-than helpful... some of the configurations made no sense, or just seemed to be deploying kit because they had it rather than because they had a reason for it. 

* [The Hook Up](https://www.youtube.com/channel/UC2gyzKcHbYfqoXA5xbyGXtQ)
   * [UniFi Network Update: Is the Dream Machine Pro Worth It?](https://www.youtube.com/watch?v=UA9ZIeRhKXU)
   * [Part 1: Ultimate Home Network 2021: WiFi 6 and UniFi Dream Machine Pro ](https://www.youtube.com/watch?v=ufJ3dPAgFiM)
   * [Part 2: Ultimate Home Network 2021: VLANs, Firewall Rules, and WiFi Networks for IoT UniFi 6.0](https://www.youtube.com/watch?v=vz3u6E3Fxi8)
   * [Part 3: Ultimate Home Network 2021: VPN, IPS, Port Security, and Port Forwarding on UniFi 6.0](https://www.youtube.com/watch?v=R6ohtF9AXkE)
* [the UniFi Dream Machine Pro....the nerdiest home router](https://www.youtube.com/watch?v=noC8t8nwji4)


## Next Steps

Well, having reached this point, it is time to revisit the RF signal measurement techniques detailed in [the second post]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/). We will take new measurements and compare the results to the initial coverage and see if things have improved.