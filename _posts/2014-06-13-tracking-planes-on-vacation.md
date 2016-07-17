---
layout: post
category: technology
title: 'Tracking Planes on Vacation'
date: 2014-06-13 00:00
tags:
- sdr
redirect_from:
- /blog/2014/6/13/tracking-planes-on-vacation
---
<img alt='Antenna' src='/images/20140613_101455.jpg' class='blogimage img-responsive'>

We spent the past week with our extended family at a cabin in the TN mountains. We do this every year or so, and - as
we normally do - we had a blast.

On one of our "in" days, I had planned to work through an experiment with the kids to show the difference between the
stock antenna for tracking airplanes via ADS-B and a custom-built antenna. We followed a number of online tutorials and
used a bunch of open source software. I have posted below are the links for some of these tools and parts in case you
want to do the same with your kids. I hope you have as much fun as we did!

* Radio - I used the cheap USB dongle available via Amazon. These are designed for allowing you to watch digital TV on
  your computer. Some smarter people than I have figured out that the chipset in these devices can be abused to do far
  more than initially advertised. I got mine for around $11 - [Cheap FM+DAB USB DVB-T RTL2832U+R820T w/ MCX antenna](http://www.amazon.com/gp/product/B00BYQMGZG/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00BYQMGZG&linkCode=as2&tag=robgillenblog-20)
* Adapter - I put a standard F connector on the end of the custom antenna cable and then needed a way to get it
  connected to the MCX adapter on the USB dongle. This little adapter helped: [RF coaxial coax cable F female to MCX
  male right angle RG316 6"](http://www.amazon.com/gp/product/B00CKG6T9I/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00CKG6T9I&linkCode=as2&tag=robgillenblog-20&linkId=SKRSHEAPEWA2CHTV)
* Powered USB Extension cable - I wanted to be able to put the antenna a fair distance from my computer (we mounted it
  on the deck of the vacation home using some zip ties). Standard COAX can result in significant signal loss, so I
  (based on the suggestions of others) purchased a powered USB extension cable and actually put the USB dongle right on
  the antenna. This is the cable I used: [Plugable 10 Meter (32 Foot) USB 2.0 Active Extension Cable Type A Male to A
  Female](http://www.amazon.com/gp/product/B004AGX4YO/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B004AGX4YO&linkCode=as2&tag=robgillenblog-20&linkId=VWBT65LBP7KMTRV4)
* Misc. Parts/Tools - there is some other stuff you need... most of which can be obtained via your local hardware
  store. I had some RG-6 coax laying around, if you don't, you'll need about 10' of it (actually only 3', but I like
  to plan for mistakes). I also had a box of F connectors and a crimping tool, so that made it easier. Finally, I used
  some 1/2" PVC to house the antenna once it was built. There is no mandate to do this, it just gave it some structure
  and a little protection from the elements. Also need to throw in some electrical tape and it is helpful if you have a
  digital multi-meter for continuity testing. Some of the tutorials used a set of calipers to measure the elements
  perfectly... we just used a standard ruler
* Tutorial 1: The idea actually came from a couple of HAK5 episodes. The thing they did for me was convince me that it
  wasn't that hard, and we could do it in a reasonable amount of time. The shows were
  [1606](http://hak5.org/episodes/hak5-1606) and [1607](http://hak5.org/episodes/hak5-1607). They built a 6' colinear,
  and I built a 3' version - primarily due to some reading that seemed to indicate the benefits gained from the extra
  3' weren't significant.
* Tutorial 2-n: The real meat of the tutorials came from these pages:
  * How To: [http://www.rtl-sdr.com/adsb-aircraft-radar-with-rtl-sdr/](http://www.rtl-sdr.com/adsb-aircraft-radar-with-rtl-sdr/)
  * Build an antenna: [http://www.balarad.net/](http://www.balarad.net/)
  * What is ADS-B: [http://en.wikipedia.org/wiki/Automatic_dependent_surveillance-broadcast](http://en.wikipedia.org/wiki/Automatic_dependent_surveillance-broadcast)
* Software: I used two main tools to process the signals:
  * ADS# - This is part of the SDR# suite of tools and takes the radio signals and serves them up as ADS-B packets. [You
    can download it at the SDRSharp site](http://sdrsharp.com/).
  * Virtual Radar Server - This is one of a number of available tools for visualizing the data. It takes a bit of
    setting up (see the How To tutorial above), but it does a great job of letting you see what is out there. [It is
    available on their site](http://www.virtualradarserver.co.uk/).

<a href='/images/virtualradar.png'>
<img alt='Virtual Radar Server' src='/images/virtualradar.png' class='blogimage img-responsive'>
</a>
