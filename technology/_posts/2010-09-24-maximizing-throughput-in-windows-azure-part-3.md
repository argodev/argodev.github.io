---
layout: post
category: technology
title: 'Maximizing Throughput in Windows Azure - Part 3'
date: 2010-09-24 00:00
tags:
- cloud computing
- azure
- storage
---

This is the third in a series of posts I’m writing while working on a paper dealing with the issue of maximizing data 
throughput when interacting with the Windows Azure compute cloud. You can read the 
[first post here](/technology/2010/09/13/maximizing-throughput-in-windows-azure-part-1/) and 
[the second here](/technology/2010/09/20/maximizing-throughput-in-windows-azure-part-2/). This post assumes you’ve read 
the other two, so if you haven’t now might be a good time to at least peruse them.

__Summary__: Based on the work performed and detailed in the first two parts of this series, we scaled the load tests 
horizontally to 20 concurrent nodes to ensure that the performance characteristics of the storage platform were not 
overly degraded. We found that while we were able to move a significant amount of data in a relatively short period of 
time (500 GB in around 10 minutes – roughly 6.9 Gbs), we experienced something less than a linear scale up from what a 
single node could transfer (up to 39% attenuation in our tests).

__Detail__: After the work done in the 
[first](/technology/2010/09/13/maximizing-throughput-in-windows-azure-part-1/) 
[two](/technology/2010/09/20/maximizing-throughput-in-windows-azure-part-2/) stages, I decided to see what the affect 
of horizontal scaling would have on the realized throughput. To test this, I took the test harness (code links below) 
and set it for the “optimal” approach for both upload and download as determined by the prior runs (sub-file chunked & 
parallelized uploads combined with whole-file parallelized downloads) and then deployed it to 20 nodes and then did a 
parameter sweep on node size. I tested a few different methods of starting all of the nodes simultaneously (including 
Wade Wegner’s 
[“Release the Hounds” approach](http://www.wadewegner.com/2010/05/release-the-hounds-multicasting-with-azure-appfabric/)) 
but settled on [Steve Marx’s](http://blog.smarx.com/) “pseudo code” (Wade’s words - not mine) approach as I had issues 
with getting multicasting on the service bus to scale using the on-demand payment model. This provided for a slightly 
crude (triggers were not *exactly* timed together) start time, but was more-or-less concurrent.

You can see from the following chart that my overall performance wasn’t too bad – based on the node type we saw upwards 
of 6Gbs download speed and around 2Gbs upload. Also consistent with our prior tests, we saw a direct relationship 
between node size and realized throughput rates.

<img alt='s3chart1' src='/images/s3chart1.png' class='blogimage img-responsive'>

While the chart above is interesting, the real question is whether or not the effective throughput was linear based on 
node count. The following charts compare the average results from three runs per node size of 20 concurrent nodes to 
the average numbers from the prior tests by node size multiplied by 20 (perfect scale). What we see is that uploads 
demonstrate an attenuation of between 25% and 45% while downloads taper between 18% and 39%.

_Note: the XL size uploads actually demonstrated a better-than-linear scale (around 101% of linear) which is attributed 
to a generally good result for the three test sets for this experiment and a comparatively poor result set (likely 
network congestion) for the XL nodes in the prior tests. The results in this test are from an average of three runs 
(each run consisting of 20 nodes transferring 50 files each) – performing more runs would likely render a higher 
accuracy of trend data._ 

<img alt='s3chart2' src='/images/s3chart2.png' class='blogimage img-responsive'>
<img alt='s3chart3' src='/images/s3chart3.png' class='blogimage img-responsive'>

Looking at the data triggered some follow-on questions such as what the attenuation curve would look like (at what node 
count do we stop scaling linearly) or what do the individual transfer times per file look like. This prompted me to dig 
a bit further into the collected data and generate some additional charts. I’ve not displayed them all here (the 
entire collection is available in the related resources section below), however I’ve selected a few that are 
illustrative of a my subsequent line of questioning.

For the downloads, most of the charts looked pretty good and we saw a distribution similar to the following two charts. 
As you can tell, the transfers are of similar length and the histogram shows a fairly tight distribution curve.

<img alt='s3chart_L_3_down' src='/images/s3chart_L_3_down.png' class='blogimage img-responsive'>

<img alt='s3chart_L_3_down_histogram' src='/images/s3chart_L_3_down_histogram.png' class='blogimage img-responsive'>

Uploads on the other hand, were all over the board. The following two charts are representative of some of the data 
inconsistencies we found. What is interesting to note here, is there there are three legs that are significantly longer 
(visually double) than the mean of the remainder. This would cause one to wonder if the storage platform was getting 
pounded, effectively placing those three nodes on hold until the pressure abated. You can see from the associated 
histogram that the distribution was much broader representing less consistency in transfer rates.


<img alt='s3chart_L_3_up_thumb' src='/images/s3chart_L_3_up_thumb.png' class='blogimage img-responsive'>

<img alt='s3chart_L_3_up_histogram' src='/images/s3chart_L_3_up_histogram.png' class='blogimage img-responsive'>

The previous charts got me to wondering further, so I wrote some code to generate charts (timeline) of transfers for 
each node within size/run collection (one chart for each of the horizontal bars in the chart above). Immediately 
obvious in the charts below is a bug in my data collection (my log data for the individual files was tracking the total 
seconds elapsed, but the end time was being recorded in minutes – resulting in the oddities (right alignment) in the 
bar display below – this will be fixed in future runs/posts). Ignoring the bug for a minute, the first chart is 
something similar to what you would expect… parallelized transfers that overlap some and stair-step over the elapsed 
time.

<img alt='s3chart_L_3_up_RD00155D323E60' src='/images/s3chart_L_3_up_RD00155D323E60.png' class='blogimage img-responsive'>

The following two charts, however, represent situations different than you would expect and illustrate what would 
appear to be problems in the network/transfer/nodes/my code (something). In both scenarios there are large blocks of 
time with apparently nothing happening, as well as individual files that apparently took significantly longer than the 
rest to transfer. In the next set of tests (and follow on blog post) I’ll be digging into this issue and looking to 
understand exactly what is happening and, hopefully, be able to explain a little bit of why.

<img alt='s3chart_L_3_up_RD00155D3243E2' src='/images/s3chart_L_3_up_RD00155D3243E2.png' class='blogimage img-responsive'>

<img alt='s3chart_L_3_up_RD00155D32444D' src='/images/s3chart_L_3_up_RD00155D32444D.png' class='blogimage img-responsive'>

<small>Research sponsored by the Laboratory Directed Research and Development Program of Oak Ridge National Laboratory, 
managed by UT-Battelle, LLC, for the U. S. Department of Energy.</small>
