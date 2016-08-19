---
layout: post
category: technology
title: 'Azure, Visualization, and Large Datasets'
date: 2009-08-05 00:00
tags:
- cloud computing
- azure
redirect_from:
- /blog/2009/8/5/azure-visualization-and-large-datasets.html
- /2009/08/05/azure-visualization-and-large-datasets/
---
I’ve been working on kicking the tires of Azure’s data functions and in the 
process was able to get my hands on a large set of climate data for testing 
purposes. I’m fighting with some size issues and azure, but thought I’d start by 
loading up some experimental temperature runs into Azure tables and then build 
a visualization tool to help the viewer to wrap his/her mind around the numbers. 
This is my first real Silverlight app and, while it has a long way to go, it’s 
an interesting first stab.

<img alt='Heat Map' src='/images/image_211328DB.png' class='blogimage img-responsive'>

Data slowness: The first big issue I encountered (and still am) is the time it 
takes to pull the 8,100 data points represented above from Azure. My current 
start-to-finish time is just under 60 seconds which is about 50 seconds too long 
for my liking. I’m still kicking around some ideas of how to speed it up and 
what I might be able to do (server side) to improve on this, but considering I 
have 40k + sets of 8,100 data points (I’d like to do client-side animation of 
the data at some point), a minute per set is prohibitively long. Even if you 
only took 100 representative sets, you are still looking at a data transfer time 
that is unacceptable.

I’m also struggling with the way in which the data is being rendered to the 
control. I’m currently using the Bing Maps CTP Silverlight control and, while it 
is certainly better than the AJAX version, once you’ve placed 8100 polygons on 
it, performance degrades. Further, since the polygons are not interactive and 
the set of them is rather static, I’m wondering if generating a raster layer or 
WMS of some sort is a better approach for the display/visualization.

The next steps in the process are to get the app cleaned up, allow the user to 
select the time window for which data should be displayed, and improve the 
performance.
