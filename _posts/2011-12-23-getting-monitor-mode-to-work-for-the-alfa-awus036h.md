---
category: technology
title: 'Getting Monitor Mode to work for the Alfa AWUS036H'
date: 2011-12-23 00:00
tags:
- security
- backtrack
redirect_from:
- /blog/2011/12/23/getting-monitor-mode-to-work-for-the-alfa-awus036h.html
---

If you’ve done much work with [BackTrack](http://backtrack-linux.org/) and wireless penetration testing you’re likely using (or at least have heard of) the [Alfa AWUS036H](http://www.amazon.com/gp/product/B002BFMZR8/ref=as_li_ss_tl?ie=UTF8&tag=robgillenblog-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=B002BFMZR8). If you haven’t, it is simply a USB-connected wireless adapter that supports long range, various external antennas, has built-in driver support in BackTrack, and supports the all-important (for this type of work) [monitor mode](http://en.wikipedia.org/wiki/Monitor_mode).

After doing a bit of reading, and preparing my lab equipment, I fired up BackTrack, attempted to put the card into monitor mode and… nothing. The following is a listing of the steps I took and what I did to get it working. At this point I should also note that I’m doing this work on an HP EliteBook 2760p which has its own in-built wireless adapter.

Start the wireless adapter by issuing `ifconfig wlan1 up` (my in-built adapter was `wlan0`). Running `ifconfig` confirmed that my adapter was seen by the operating system

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/ifconfig01.png"><img src="{{ site.url }}{{ site.baseurl }}/images/ifconfig01.png" alt="ifconfig01"></a>
</figure>

Then I attempted to list the available interfaces for monitoring using the [aircrack-ng tools](http://www.aircrack-ng.org/)

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/airmon01.png"><img src="{{ site.url }}{{ site.baseurl }}/images/airmon01.png" alt="airmon01"></a>
</figure>

and it would just hang here for as long as I wanted to wait.

I spent a good bit of time poking around and trying to ascertain what was/wasn’t working and assumed that maybe it was a driver issue. I ran `lshw –c network` to get a list of my network devices and the drivers that they were using.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/lshw01.png"><img src="{{ site.url }}{{ site.baseurl }}/images/lshw01.png" alt="lshw01"></a>
</figure>

From this, I could see that both devices were loaded and appeared to be running the correct drivers. On a whim, I decided to eliminate extra variables and disable the in-built wireless card by issuing `modprobe –r iwlagn` (the driver for the built-in card).

I then went back to see if airmon-ng would see my Alfa card, which it did:

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/airmon02.png"><img src="{{ site.url }}{{ site.baseurl }}/images/airmon02.png" alt="airmon02"></a>
</figure>

Encouraged by this, I attempted to put it in monitor mode (`airmon-ng start wlan1`) which also succeeded:

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/airmon03.png"><img src="{{ site.url }}{{ site.baseurl }}/images/airmon03.png" alt="airmon03"></a>
</figure>

At this point, running `ifconfig` showed both the wireless card and the monitor-mode device.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/ifconfig02.png"><img src="{{ site.url }}{{ site.baseurl }}/images/ifconfig02.png" alt="ifconfig02"></a>
</figure>

And running [WireShark](http://www.wireshark.org/) or other tools were now able to see the device and capture packets.
