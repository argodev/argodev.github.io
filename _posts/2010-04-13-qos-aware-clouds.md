---
layout: post
category: technology
title: 'QoS Aware Clouds'
date: 2010-04-13 00:00
tags:
- cloud computing
- theory
redirect_from:
- /blog/2010/4/13/qos-aware-clouds.html
---
I’ve been [reading a paper](http://research.microsoft.com/apps/pubs/default.aspx?id=118372) this morning published by
Microsoft Research on [Quality of Service Aware Clouds](http://research.microsoft.com/apps/pubs/default.aspx?id=118372).
If you are engaged in the cloud computing field, I would suggest that it is worth the time to read (14 pages) if for no
other reason than to get your mind rolling (as it did mine) on the topic. Further, I’d be keenly interested in follow-on
conversations from the community as to the issues/remedies put forth in that paper.

I’m finding myself split on the topic… academically, there are some interesting points being made:

- VMs from different customers running on the same physical host can negatively impact each other (think, last-level
  cache contention, memory bandwidth, I/O paths, etc.) (this isn’t a surprise to anyone, just the premise on which the
  rest of the paper is based)
- They suggest an intelligent VM placement algorithm based on resource utilization models of the applications running
  in the VMs
- They suggest reserving a certain amount of headroom on each physical host to allow for dynamic compensation and CPU
  throttling adjustments to maintain QoS
- They suggest addressing the “wasted” resources represented by the headroom in the normative case by means of a
  bit-based “higher quality” service level available to users for additional fees
- The key premise is that many apps hosted in the cloud are *not* CPU bound, and putting those that are along side
  those that are not will provide everyone with a reasonable level of service (as compared to putting all CPU-bound VMs
  on the same nodes resulting in resource contention issues for those nodes whereas other nodes with lighter workloads
  are, effectively, sleeping).


However, I find myself struggling with a few things:

- The solution they propose is based on the ability to accurately model the workload of a given VM (they suggest in a
  non-contended staging area) and to then to the initial production VM placement based on a balancing algorithm. I
  struggle with this as I think the majority of cases are going to be either “quick hits” (user is just posting a
  handful of VMs to use for awhile after which they will be torn down) or scenarios in which the cost of eeking out 1
  00% QoS consistency is going to be greater than simply “spinning up another VM”. I’m guessing that the later case is
  more likely, and that most users will simply accept the balanced performance for what it is, and adjust their total
  number of VMs accordingly. The exception to this rule will likely be permanent (or nearly so) installations (wherein
  the cost of running nodes for a long time is higher)
- They propose that the cloud providers insert “head room” into their resource deployment strategy (as a means of
  compensating for contention) and then mitigate this “waste” by selling higher levels of Quality to interested
  customers who are willing to bid if you will for increased performance when available but content to live with a
  lesser service level in the normative case. I struggle with this as it, in my mind, inserts another level of
  complexity to the pricing model of cloud computing that simply will not survive in the market place. From the vantage
  point of the user, this would further introduce variance into my overall QoS as, the normative case *might* be that I
  run at the higher service level (normally the host is not experiencing high levels of interference) but I will be
  dropped to the lower level without notice. This could add significantly to my auto-scaling complexity as I now no
  longer need to scale up/down simply based on traffic or load, but also have to monitor the QoS state I’m currently
  being provided by the cloud provider.
- They discuss using market-based “bidding” for higher QoS levels which I think is problematic due to the fact that they
  are, in this case, asserting that Quality of Service 0 (Q0) (the normative state) is something less than a full core
  (in their examples, something around 50%) and that Q1 is higher (maybe 75%). The problem here is perception vs.
  reality in that most users of cloud platforms would assume that when they get a single-core VM, they are getting ALL
  of that VM. Therefore, asserting that what you are really getting is 50% of said core, and that if you pay more,
  we’ll periodically give you more (except for when we don’t due to someone else on the same host over utilizing their
  portion) seems a difficult sell.
- The algorithm and approach targets the “behaving” code rather than punishing the misbehaving code. Rather than
determining which VM on the chip is overrunning the rest and curtailing that, they attempt to simply help those who are
under performing.


I think, that in the end, I’m more in favor of simply having more intelligent hypervisors that provide better isolation
for VMs, but I’m still thinking this all through. There are some interesting points made in this paper, and intelligent
allocations could be interesting…
