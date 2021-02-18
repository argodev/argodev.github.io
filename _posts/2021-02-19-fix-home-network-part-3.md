---
category: technology
title: 'Fixing My Home Network: Part 3'
date: 2021-02-18 12:15
tags:
- networking
- wifi
- iperf
- iperf3
description: "This is the third in a series of ten posts I'm writing regarding on the topic of fixing up my home network. In the first post I introduced the project and provided some of the motivations and constraints. In the second, I described the tooling I used to evaluate my 'pre-upgrade' signal coverage which is one of three 'before' steps I performed to accurately understand the pre-condition of my environment. This is the second of the evaluation steps in which we measure the internal network performance."
---

This is the third in a series of ten posts I'm writing regarding on the topic of fixing up my home network. In the [first post]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/) I introduced the project and provided some of the motivations and constraints. In [the second]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/), I described the tooling I used to evaluate my "pre-upgrade" signal coverage which is one of three "before" steps I performed to accurately understand the pre-condition of my environment. This is the second of the evaluation steps in which we measure the _internal_ network performance.

The posts in this series are as follows:

* [Part 1: Introduction and background]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/)
* [Part 2: Establishing an RF baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/)
* [Part 3: Internal Network Baseline (this post)]({{ site.url }}{{ site.baseurl }}/technology/2021/02/18/fix-home-network-part-3/)
* Part 4: External Network Baseline
* Part 5: Selecting the New Eqiuipment
* Part 6: Deploying the New Equipment
* Part 7: Resulting RF Baseline
* Part 8: New Internal/External Network Measurements
* Part 9: Comparison and Initial Results
* Part 10: One-Year Later

## Background

For some home environments, this stage may not matter at all. For example, at my mother's home, nearly all the network communication is between various devices (iPad, computer, TV dongle, etc.) and the Internet. Quite rarely does one device on that network speak directly to another (some appear to, but are actually cloud-service-brokered). What matters in _that_ situation is the topic of my next post: the internal-external network interactions. However, in _my_ enviornment, I have a network attached storage server (NAS), a [Plex media server](https://www.plex.tv/) (actually just an old laptop stuck in the network closet), and a number of more minor data collection systems running. For this situation, device-to-device performance is similarly important to device-to-Internet - particularly with regards to media streaming via Plex. I say all of that to point out that depending on your usage scenario, this step may not matter at all.


## Tools

By contrast to the tools availble for analyzing and visualizing the RF spectrum coverage in your home, high-quality tools for assessing your internal-network transfer rates are available at no cost. Additionally, if you are willing to do a little work, you can robustly analyze the results in nearly whatever form you choose.

### iperf3

For the purpose of taking the measurements, I used the `iperf3` tool. Now, if you search for this, you will likely notice that the first hits are for [https://iperf.fr](https://iperf.fr). I'm uncertain the relationship between this first site and what I _think_ is the official site: [https://software.es.net/iperf/](https://software.es.net/iperf/). The tool is principly develop3ed by [ESnet](http://www.es.net/) and the [Lawrence Berkely National Laboratory](http://www.lbl.gov/) - a sister organization to [my employer](https://ornl.gov). As part of the supercomputing mission of the Department of Energy (DOE) national laboratories, quite a bit of data is generated which results in a need for some extrememe network technologies to faciliate data movement. These technologies need tools for evaluation and verification, which results in things such as iperf3. If you are a source-code kind of person, you can grab the latest at their [github site](https://github.com/esnet/iperf). If you are running a Linux variant, it is quite possible that a useable version is available via your in-built package manager. Additional documentation on how to use the tool is [available here](https://fasterdata.es.net/performance-testing/network-troubleshooting-tools/iperf/).

### JupyterLab

`iperf3` supports many data output formats including machine-readable options such as `csv` and `json`. Of course, if we are going to process these we either need to use the most [widely-used analytics package in the world](https://office.live.com/start/excel.aspx), or we can crack open a popular data scientist-oriented tool such as [Jupyter](https://jupyter.org/). Because I have familiarity with the latter and enjoy the flexibiliity it provides, that is the option I selected. Those of you familiar with this platform will need no convincing, but for those who don't know it, it is essentially a python-supporting scratchpad that provides a high-level of interactivity while also supporting some serious code libraries. I find myself using it nearly any time I am "playing around" with data as it helps me get from raw data to insight quite rapidly. It is available for free and the best starting point [is their documentation](https://jupyter.org/install).

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/homenet_jupyter.png"><img src="{{ site.url }}{{ site.baseurl }}/images/homenet_jupyter.png" alt="Jupyter Lab"></a>
  <figcaption>Figure 1: Looking at iperf3 data in Jupyter Lab</figcaption>
</figure> 

## Methodology

My approach to gathering data for this was reasonably straight-forward. As discussed in the first post, I have four independent (yet related) wireless networks and also my hard-wired Ethernet links. This means, at each test point, I'd like to measure each of those wireless networks. I considered our use-cases, and selected 8 different locations that covered our most common needs: the kitchen table, our sunroom, my office, the master bedroom, each of the three kid bedrooms, and the garage. Further, I've been collecting data long enough that I know you can't always trust a given measurement so you need to take _some_: enough to ensure you aren't basing decisions on a misleading outlier or two. Given a desire to balance my time with interest in accurace, I selected 5 samples as my goal for each test. Therefore, given **4 networks**, each being measured at **8 locations** and each measurement being taken **5 times**, I end up with **_120 measurements_** (_not counting the wired connections_).

The test setup included two different laptops. The first, I treated as a _"server"_ and attached to the Netgear switch in my main network closet ([checkout my network diagram in my first post]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/#network-layout)), This system ran `iperf` in server mode. This system was running Ubuntu 20.04, has 32 GB of RAM and an SSD.

```bash
$ iperf3 -s
```

**ProTip:** Both test systems had hard-wired, _built-in_ Ethernet jacks. I selected systems like this because I wanted to avoid issues due to USB->Ethernet dongles, etc.
{: .notice--info}

The field/test system was another laptop that is a few years old, but has a good NIC, 16 GB of RAM, and an SSD. This was also running Ubuntu 20.04. I probably would have done this differently knowing what I know now about iperf3, but I ran the following on the client for each measurement:

```bash
$ iperf3 -c [ip_addr_of_server] --bidir -i 10 -J \ 
    --logfile [logname].json
```

This tells the system to connect to the server and perform a bi-directional test. It only reports after 10 seconds, and then stores the results to a json file. 

**Note:** The biggest _problem_ I had with this (and I didn't realize it until later) is that when using bi-directional mode, the generated JSON is a little unfriendly for python analysis as it contains duplicate keys. I would have been better off to run a forward test and save the results to one file and then perform a reverse test and dump that to a different file. As it was, I manually (groan) edited the files after collection and prior to analysis. (I changed the second set of `sum_sent` and `sum_received` nodes in the `end` element to be `sum_sent_s` and `sum_received_s` as they represented the reverse test... the server reaching back to the client.)
{: .notice--warning}

## Results

The first real test was the performance of the hard-line ethernet connections. I did this first as it establishes the baseline for the baseline... meaning... no performance on any part of the network will be better than this, so this provides a reference for understanding the wireless network performance.

### Wired Network Performance

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wired.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wired.png" alt="wired speeds"></a>
  <figcaption>Figure 2: Internal Network Transfer Speeds (Wired) [click to enlarge]</figcaption>
</figure> 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wired_rexmit.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wired_rexmit.png" alt="wired retransmissions"></a>
  <figcaption>Figure 3: Internal Network Transfer Retransmissions (Wired) [click to enlarge]</figcaption>
</figure> 

There's a fair bit going on here, so let's dig into these before looking at the measurements from the wireless tests. In both figures 2 and 3, the blue points indicate data being sent from the client/test machine and then being received by the server. The orange data points are the reverse direction. 

Additionally, if you are not familiar with box plots (the gray shapes behind the normal data points), don't stress... they are quite easy to understand. Quoting from [the Seaborn webpage](https://en.wikipedia.org/wiki/Box_plot):

> A box plot (or box-and-whisker plot) shows the distribution of quantitative data in a way that facilitates comparisons between variables or across levels of a categorical variable. The box shows the quartiles of the dataset while the whiskers extend to show the rest of the distribution, except for points that are determined to be “outliers” using a method that is a function of the inter-quartile range.

Clear as mud, right? Putting it in more down-to-earth terms, a box plot generally represents 5 numbers. The 0th quartile (0th percentile), is the lowest number in the set. The 4th quartile is the highest number (100th percentile) in the set. These two are represented by the lower and upper "whiskers" on each boxplot. The 2nd quartile (50th percentile) is the middle value of the dataset. This is the line in the middle of the boxes. The bottom and top of the boxes are the 1st and 3rd quartiles and they represent the median of the lower half of the dataset and median of the upper half respectively. All of this is, of course, ignoring any mathematically-determined outliers. If you care to know more, or understand how the outliers are determined, [this page has a good writeup](https://en.wikipedia.org/wiki/Box_plot). A fair question at this point might be, _"Why go through all this trouble? Why not just give us the average and move on?"_ The reason is that an average doesn't tell you anything about the shape of the data... or how spread out it is. Looking at a box plot, specifically one without the datapoints plotted on top of it, you can immediately understand where the midpoint is, but also how close the rest of the points in the set are to that midpoint. This gives (or removes) confidence in using that midpoint as a good rule of thumb. Admittedly, this would be far more helpful if there were more than 5 measurements per collection point in my set.

**ProTip:** As any data person will tell you, be sure to notice the bounds of the `Y` axis. In this plot, I let `matplotlib` determine the best range simply to make the data clear and visible. If I had used a 0-based y-axis, all of the data in the first chart would have simply been flat lines that you would be unable to distinguish. The point in this case is to illustrate the plotting methodology that we will use in subequent graphs, not to communicate an overly-large variance in the data. *Quite the opposite.* In Figure 2, the data is really quite consistent (within 3-4 Mbps across all tests) - that is essentially _"flat"_.
{: .notice--info}

The numbers here (approximately 930 Mbps) are exactly what we'd expect for a wired, 1 Gbps network. There's always some overhead at the switch and physical layer which is why you'll rarely measure too close to the actual line rate. I should also mention that, if you really care about it, `iperf` recommends all sorts of test machine tuning (processor affinity, nic tuning, etc.) that can help you get better results. I figure that the out-of-the-box configuration is good enough for my purposes.

Figure 3 simply shows the retransmission rate that occurred during the test. This accounts for what may be a discrepency between the rate that one side of the test was sending at and what the remote side received at. Here we use the received rate as our measurement (see _Effective Transmit Rate_ on charts) as that is what was actually accomplished, regardless of how hard the sender was working. On the wired network, we have only one collection where we had any retransmissions - all of the others were 0.


### Wireless Network Performance

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless.png" alt="wired speeds"></a>
  <figcaption>Figure 4: Internal Network Transfer Speeds (Wireless) [click to enlarge]</figcaption>
</figure> 

Figure 4 is the wireless complement to figure 2 and the data is not altogether surprising. The first observation is that the data rates are much lower... ranging from the high 10s of Mbps to the low 100 Mbps range. We also see a fairly big change in speeds based on location. For example, sitting at the kitchen table is pretty good, but sitting in bedroom 2 or the sunroom is pretty well unusable. 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless_ssid.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless_ssid.png" alt="wired speeds by SSID"></a>
  <figcaption>Figure 5: Internal Network Transfer Speeds by SSID [click to enlarge]</figcaption>
</figure> 

Figure 5 is the same data is Figure 4, but this time broken out by the individual wireless networks (SSID). Somewhat inexplicably, we see the `main_2G` shows similar transfer rates as the `main_5G`. This *was* a **Wifi 6** router, so maybe that had something to do with it. We see a good bit of similarity between the first three quadrants with the fourth, `kids_2G` dropping off dramatically, which is to be expected for a router with technology that is over 5 years old.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless_rexmit.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless_rexmit.png" alt="wired retransmissions"></a>
  <figcaption>Figure 6: Internal Network Transfer Retransmissions (Wireless) [click to enlarge]</figcaption>
</figure> 

It isn't terribly surprising that the retransmission rates would be higher for wireless networks (as compared to hard wired), and Figure 6 shows that they are. Of more interest maybe is Figure 7, which with the same data but now broken out by SSID, we see that the majority of the retransmissions occured with the 5Ghz side of the older kids-network router. 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless_rexmit_ssid.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wireless_rexmit_ssid.png" alt="wired retransmissions by SSID"></a>
  <figcaption>Figure 7: Internal Network Transfer Retransmissions by SSID [click to enlarge]</figcaption>
</figure> 

### Wired vs Wireless

This section probably isn't necessary, but I thought it might be good to simply document the difference between the two, especially for subsequent comparisons.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wired_vs_wireless.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_internal_wired_vs_wireless.png" alt="wired vs wireless speeds"></a>
  <figcaption>Figure 8: Internal Network Transfer Speeds (Wired vs. Wireless) [click to enlarge]</figcaption>
</figure> 

Figure 8 is the combination/flattening of Figures 2 and 4. Its no surprise that the mean tranasfer rate for the wired connections is **930 Mbps** wereas the same value for the wireless tests is **64.8 Mbps**. The key takeaway from this chart is that if you are moving any real volume of data and you have the option, use a wired connection.


## Next Steps

OK... that was alot, and we should probably wrap it up here. In my next post, we apply a similar methodolgy to measuring the performance of our local network to remote, Internet-based services. At that point, we will have a reasonably complete characterization of the "before" picture. Then we finally get to start making some changes.
