---
layout: post
category: technology
title: 'Fixing My Home Network: Part 2'
date: 2021-02-12 08:00
tags:
- networking
- wifi
- netspot
description: "In my last post, I provided some background for this series and introduced the environment. In this post I describe how I measured the effectiveness (or not) of my current WiFi system and collected data to inform my upgrade/changes."
---

In [my last post](https://robgillen.com/technology/2021/02/05/fix-home-network-part-1/), I provided some background for this series and introduced the environment. In this post I describe how I measured the effectiveness (or not) of my current WiFi system and collected data to inform my upgrade/changes.

The posts in this series are as follows:

* [Part 1: Introduction and background](https://robgillen.com/technology/2021/02/05/fix-home-network-part-1/)
* [Part 2: Establishing an RF baseline (this post)](https://robgillen.com/technology/2021/02/12/fix-home-network-part-2/)
* Part 3: Internal Network Baseline
* Part 4: External Network Baseline
* Part 5: Selecting the New Eqiuipment
* Part 6: Deploying the New Equipment
* Part 7: Resulting RF Baseline
* Part 8: New Internal/External Network Measurements
* Part 9: Comparison and Initial Results
* Part 10: One-Year Later

## Background

In the previous post, I discussed a number of the coverage issues we seemed to be having with the WiFi network at our house. The problem is, much of that is anecdotal. My son _says_ things are slow in his room. It _feels_ like a particular device is slow on the network. It _just seems_ unstable. While this is all likely true, it is difficult to quantify feelings, and I specifically wanted to be able to assess the situation, make some changes, and then reassess with the goal of measuring (quantitatively) the difference between the two states. Clearly, user opinions and surveys are probably not the most reliable metric here.

## Tools

There are many, high-end and expensive tools for measuring wireless signal and designing systems for professional installations. For some examples, [check out this post](https://badfi.com/toolroll) where the author, [Eddie Forero](https://twitter.com/BadFiShow), lists a number of tools. The ones he recommends are all in the $500+ range and the _good_ ones are all over $1,000. In fact, one of those tools - [Ekahau Pro](https://www.ekahau.com/products/ekahau-connect/pro/) is around $8,700! While I would enjoy testing these, that's a bit beyond my needs. I'm just looking for a sanity check... do I _really_ have a problem and can I make it better. 

After looking at a number of different options, I settled on the [NetSpot](https://www.netspotapp.com/) utility. This is far from perfect, and their adversitement approaches leave a little bit of a bad taste with me, but it does what I need it to. You start by providing a drawing/base map of your environment and give it a concrete measurement from which it calculates the scale. You then take a number of measurements with the built-in WiFi radio and it produces a number of reports that help you understand what is going on.

## Caveats

As cool as this tool is, and as helpful as it was for me, I decided that I simply wasn't comfortable providing an accurate-scale drawing of my house and all of the rooms in it online for the world to see. I probably share more online than many, but that is just too much. It was more of a struggle than it might seem, as I think it is particularly instructive to see a real scenario and how it can inform some of your choices. Therefore, rather than using the results from my own home, for the examples in *this post*, I am going to show the scan I did for one of the buildings my church is leasing. While it will be slightly disjoint from the other posts in this series, it should give you enough of an idea to map to your scenario.

## The Building

In order to begin the survey, you need a scale-accurate drawing of the enviornment. It doesn't have to be perfect, but it is helpful if it is close. I've included the blank drawing below. I created this in [Sketchup](https://app.sketchup.com/app) and all of the measurements are to scale. Of course, the wall aren't full of holes out to the outside world, I simply didn't include doors on the drawing.

![Basic Building Layout](/images/ICCC_too.png)

This is an older building that was built and scabbed together. We are using it for a few years as the lease rate can't be beat. It is essentially two buildings that have been connected... lower right is the original building and the upper left is the "newer" (relative) portion. All of the exterior walls are concrete block. The main Internet connection (and router location) is at the sound booth - the vertical rectangle in the mid-left of the newer building. This means that for signal to reach the classrooms in the older wing, it must penetrate mulitple concrete block walls. As you might imagine, there is a bit of attenuation.

To give you an idea of the scale, entire complex is measured (per the engineering drawings) at just over 8,100 square feet. The classroom in the lower left of the old building is just under 700 square feet. 

## Process

The process of performing the survey is quite simple. You load the drawing up into survey tool, set the scale, and then begin walking around and taking measurements. As you do, the system "fill in" the drawing with detail showing its coverage information and showing where you have taken measurements. You continue taking measurements until all of the areas you care about have been analyzed and then you generate the reports. The image below shows me partially through the process of scanning the building.

> INSERT IMAGE FROM SCAN

## Analysis

Now that we have performed the survey, we can look at the results and draw some conclusions. 

> INSERT IMAGES from REPORT

> Download/Upload speed images



> Overlapping Singal Image

Discuss how this compares with what I saw at my house.


## Next Steps

In my next post, I return to my home network and detail how I characterized the performance of the internal network and tried to understand the quality of service in the different areas of my house.