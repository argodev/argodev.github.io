---
layout: post
category: technology
title: 'Getting Monitor Mode to work for the Alfa AWUS036H'
date: 2011-12-23 00:00
tags:
- security
- backtrack
---
If you’ve done much work with [BackTrack](http://backtrack-linux.org/) and wireless penetration testing you’re likely
using (or at least have heard of) the [Alfa AWUS036H](http://www.amazon.com/gp/product/B002BFMZR8/ref=as_li_ss_tl?ie=UTF8&tag=robgillenblog-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=B002BFMZR8).
If you haven’t, it is simply a USB-connected wireless adapter that supports long range, various external antennas, has
built-in driver support in BackTrack, and supports the all-important (for this type of work)
[monitor mode](http://en.wikipedia.org/wiki/Monitor_mode).

After doing a bit of reading, and preparing my lab equipment, I fired up BackTrack, attempted to put the card into
monitor mode and… nothing. The following is a listing of the steps I took and what I did to get it working. At this
point I should also note that I’m doing this work on an HP EliteBook 2760p which has its own in-built wireless adapter.

Start the wireless adapter by issuing `ifconfig wlan1 up` (my in-built adapter was `wlan0`). Running `ifconfig` confirmed
that my adapter was seen by the operating system

<img alt='ifconfig01' src='/images/ifconfig01.png' class='blogimage img-responsive'>

Then I attempted to list the available interfaces for monitoring using the [aircrack-ng tools](http://www.aircrack-ng.org/)

<img alt='airmon01' src='/images/airmon01.png' class='blogimage img-responsive'>

and it would just hang here for as long as I wanted to wait.

I spent a good bit of time poking around and trying to ascertain what was/wasn’t working and assumed that maybe it was
a driver issue. I ran `lshw –c network` to get a list of my network devices and the drivers that they were using.

<img alt='lshw01' src='/images/lshw01.png' class='blogimage img-responsive'>

From this, I could see that both devices were loaded and appeared to be running the correct drivers. On a whim, I
decided to eliminate extra variables and disable the in-built wireless card by issuing `modprobe –r iwlagn`
(the driver for the built-in card).

I then went back to see if airmon-ng would see my Alfa card, which it did:

<img alt='airmon02' src='/images/airmon02.png' class='blogimage img-responsive'>

Encouraged by this, I attempted to put it in monitor mode (`airmon-ng start wlan1`) which also succeeded:

<img alt='airmon03' src='/images/airmon03.png' class='blogimage img-responsive'>

At this point, running `ifconfig` showed both the wireless card and the monitor-mode device.

<img alt='ifconfig02' src='/images/ifconfig02.png' class='blogimage img-responsive'>

And running [WireShark](http://www.wireshark.org/) or other tools were now able to see the device and capture packets.
