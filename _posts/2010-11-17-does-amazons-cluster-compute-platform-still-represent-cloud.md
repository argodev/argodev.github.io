---
layout: post
category: technology
title: 'Does Amazon’s Cluster Compute Platform Still Represent Cloud Computing?'
date: 2010-11-17 00:00
tags:
- cloud computing
- aws
redirect_from:
- /blog/2010/11/17/does-amazons-cluster-compute-platform-still-represent-cloud.html
---
I’m sitting at the airport in New Orleans, after having attended the first half of the
[ACM/IEEE 2010 Super Computing](http://www.acm.org/) conference. This was the first time I have attended this
conference, and it was certainly interesting to participate.

During the workshop I participated in on Sunday ([Petascale Data Analytics on Clouds: Trends, Challenges, and
Opportunities](http://www.ornl.gov/sci/knowledgediscovery/CloudComputing/PDAC-SC10/)), there arose a conversation
regarding the Amazon EC2 “[cluster compute instances](http://aws.amazon.com/hpc-applications/)” and their having reached
a spot on the [Top 500](http://top500.org/) list. What surprised me, however, was not that they were mentioned (I
actually expected them to receive more attention than they did), but that they were described as __*not*__ being “real”
cloud computing.  The point was made that they represented some sort of special configuration that was done just for the
tests and that the offering was somehow significantly different than the rest of the general populous could acquire.
The two primary individuals involved in the exchange have significant history in classic HPC and have, at least a degree
of “anti-cloud” bias, but I am responsible for helping influence the viewpoint of one of these folks so I’ve been
thinking a bit over the past few days about how to properly articulate the inaccuracies of the argument… and wondering
if it really matters anyway.

**Commodity Hardware** – by this I mean that the platforms being utilized could be purchased/deployed by anyone… and,
by “anyone”, I am thinking of a moderately skilled computer hobbyist. I’m referring, particularly, to the chip
architectures, availability of the motherboards, etc. A
[quick glance at the specs](http://aws.amazon.com/hpc-applications/) for a given machine validates that anyone (with
enough money) could easily assemble a similarly-configured machine. It is simply a quad-core Intel box with 24 GB of
RAM and roughly 2TB of disk. One might argue that the newly-announced Cluster GPU Instance is specialized hardware, but
then again, [anyone with an extra $2,700 to spare](http://www.dreamhardware.com/store/product/index.php?product_id=1795789)
could add one of these to their machine. The point is, that machines in this class are in the 5K range, not the 50K or
500K range.

**Commodity Networking** – now to some of you, 10GB non-blocking networks might seem specialized or exotic, but – at
least in the HPC realm – it isn’t. Most serious HPC platforms utilize a network technology called
[InfiniBand](http://en.wikipedia.org/wiki/Infiniband) (usually QDR) or something fancier (more expensive such as an IBM
custom interconnect or CRAY’s Gemini. A quick search shows one could purchase 10GBE switches starting in the 2-3K
range and going up from there whereas IB QDR switches are at least double that.

**Broad Availability** – this point gets a little stickier. The point is, that anyone can get access to CCI nodes at
any point – simply using a credit card and visiting the AWS website. However, getting access to 880 of them (the number
used in the Top 500 run) is likely to be more difficult. The reason is not an unwillingness on Amazon’s part to provide
this (I’m sure, given the proper commitment, this would not be impossible), but rather a question of economics and
scale. Their more “general” nodes have a large demand and use case… the scale of demand for CCI nodes is yet to be
established although I’d imagine the sweet spot for these customers is in the 16-64 node range… folks who could really
use a cluster some of the time, but certainly don’t need it all of the time. As such, I (and I have no inside knowledge
of their supply/demand change) don’t imagine that the demand is currently so large that beyond the currently active
nodes, they have ~1000 nodes of this instance type sitting around just waiting for you to request them (this will likely
changes as demand grows).

**Inexpensive + Utility-style Pricing** – This is one area where this instance type represents all of the goodness we
have become accustomed to in the cloud computing world. These nodes (remember I listed the above as starting around 5K)
are available at $1.60/hour ($2.10/hour for the GPU-enabled nodes). This makes a significant computing platform
available to almost anyone. For just over $100/hour, you can have a reasonably-well powered 64-node cluster on which to
run your experiments… __*that*__ is disruptive in my opinion. The best part about it, is that this price is the worst case
scenario – meaning, this is the price with no special arrangement, or reservation, or volume discount, or anything. It
represents no long term commitment… nothing beyond a commitment for the current hour.

So… what is different? – I have spent the majority of this post explaining how I think that these instance types are
similar in many ways to other IaaS offerings and thereby deserve categorization as “regular” cloud computing, but that
begs the question – what is unique about these nodes that would cause Amazon to promote them as better for HPC
workloads? What facts formed the foundation for these rather experienced HPC experts to classify them as different? In
my mind, there is really only 2 or three things here. The first is the networking – rather than being connected to a
shared 1GBE network, you are given access to a 10GBE network, and guaranteed full bisection bandwidth node-to-node. It
is this fact alone that makes the platform so interesting to the HPC folks as it makes it actually viable for
network-heavy applications (think traditional MPI apps). Secondly, you have clear visibility to the hardware. Amazon
tells you exactly what type of processors you are running on allowing you to optimize your codes for that particular
processor (somewhat common in the HPC realm). Tightly coupled with this fact is that you can’t get a “part” of this
instance type. You get the entire node (less the hypervisor) and, as such, are not contending with any other customers
for node-local resources (RAM, ephemeral disks, network, etc). Finally, the fact that you can get nodes that have
specialized hardware (NVidia GPUs) is unique… there are very few cloud providers currently offering this sort of
feature set.

In the end, I think the Amazon offerings are very much representative of the “cloud” and, particularly, of where the
cloud is going. I think we will continue to see a broad level of homogeneity (basic hardware abstractions) with
comparatively small pockets of broad-domain specific assets. The key being that for a large number of researchers, the
offerings announced by Amazon this summer (and additionally this week) make the decision as to whether or not to buy
that new departmental cluster much more difficult – especially when a true TCO analysis is performed. These are similar
to the arguments and justifications for “normal” cloud compute scenarios and as such, should be considered one and the
same.
