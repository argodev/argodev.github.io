---
layout: post
category: technology
title: 'All Your RFz Belong To Me'
date: 2013-08-05 00:00
tags:
- conferences
- security
- defcon
redirect_from:
- /blog/2013/8/5/all-your-rfz-belong-to-me.html
---
This was one of the best sessions that I attended at DefCon, and was also the longest (double-length). The room was
packed, and the aroma “fresh”... however the content made up for all of that.

Essentially, the guy is an RF nerd who, utilizing old-style equipment and now SDR, pokes around with (i.e. listens to)
signals in the air and tries to figure out what they are.

As an example of what he has been learning, he referred to the ATCBRS and, of particular interest, the ADS-B Mode S
signals that are provided by all airplanes (<http://en.wikipedia.org/wiki/Automatic_dependent_surveillance-broadcast>).
He demonstrated an application he has written that will simply listen to the (unencrypted) signals in the air near
airplane traffic paths. They include all sorts of information about the plane, including GPS location, status of
on-board equipment, etc. It is fascinating that the information is out there, that it is unencrypted, and that,
technically, you could transmit the signal yourself (NOTE: this is illegal).

If you are thinking through what I just wrote, and saying “no... that can't be true”, I point you to the following:
<http://maps.spench.net/aviation/> and <http://spench.net/drupal/research/mode-s>

A couple of links/tools of particular interest:

* RTL2832: low-cost entry-level SDR stick.
<http://www.amazon.com/Cheap-DVB-T-RTL2832U-antenna-Hotsale/dp/B00BYQMGZG/ref=sr_1_14?ie=UTF8&qid=1375729880&sr=8-14&keywords=RTL2832>

* Speaker's website: <http://spench.net>

* Company speaker works for: <http://www.ettus.com/>

* GNU Radio (software for building processing blocks, etc.) <http://gnuradio.org/redmine/projects/gnuradio/wiki>

* Open BTS – create your own 3G base station: <http://openbts.org/>

* Open LTE – create your own LTE base station: <http://sourceforge.net/projects/openlte/>

* Baudline – signal analyzer <http://www.baudline.com/>

* ATCRBS – Air Traffic Control Radar Beacon System:
<http://en.wikipedia.org/wiki/Air_traffic_control_radar_beacon_system>
