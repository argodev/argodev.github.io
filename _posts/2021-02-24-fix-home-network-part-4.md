---
category: technology
title: 'Fixing My Home Network: Part 4'
date: 2021-02-24 08:00
tags:
- homenetwork
- networking
- wifi
- speedtest
excerpt: "In most homes, the most important metric for network performance is bidirectional connectivity to Internet-hosted services. The traffic generated by the six individuals living in my home is no different. Here I test how the 'before' version of our network performs talking to Internet services. I am going to attempt to keep this post a little shorter than the last - many of the explanations and much of the methodology is the same. I will point back to that one as necessary - if you haven't yet read it, you may find it helpful to do so prior to continuing."
toc: True
---

This the last of my "before" posts in my [10-part series]({{ site.url }}{{ site.baseurl }}/tags/homenetwork/) on upgrading my home network. In the [last post]({{ site.url }}{{ site.baseurl }}/technology/2021/02/18/fix-home-network-part-3/), we took a somewhat detailed look at the performance of the _internal_ network. This post will build on that foundation and discuss the performance of the various locations with **external** (Internet) based services.

The [posts in this series]({{ site.url }}{{ site.baseurl }}/tags/homenetwork/) are as follows:

* [Part 1: Introduction and background]({{ site.url }}{{ site.baseurl }}/technology/2021/02/05/fix-home-network-part-1/)
* [Part 2: Establishing an RF baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/11/fix-home-network-part-2/)
* [Part 3: Internal Network Baseline]({{ site.url }}{{ site.baseurl }}/technology/2021/02/18/fix-home-network-part-3/)
* [Part 4: External Network Baseline (this post)]({{ site.url }}{{ site.baseurl }}/technology/2021/02/24/fix-home-network-part-4/)
* [Part 5: Selecting the New Eqiuipment]({{ site.url }}{{ site.baseurl }}/technology/2021/03/05/fix-home-network-part-5/)
* [Part 6: Deploying the New Equipment]({{ site.url }}{{ site.baseurl }}/technology/2021/03/17/fix-home-network-part-6/)
* Part 7: Resulting RF Baseline
* Part 8: New Internal/External Network Measurements
* Part 9: Comparison and Initial Results
* Part 10: One-Year Later

## Background

In most homes, the most important metric for network performance is bidirectional connectivity to Internet-hosted services. The traffic generated by the six individuals living in my home is no different. Here I test how the "before" version of our network performs talking to Internet services. I am going to attempt to keep this post a little shorter than the last - many of the explanations and much of the methodology is the same. I will [point back to that one]({{ site.url }}{{ site.baseurl }}/technology/2021/02/18/fix-home-network-part-3/) as necessary - if you haven't yet read it, you may find it helpful to do so prior to continuing.

## Tools

There are a number of tools and methods for testing Internet performance and, while I could have just used `iperf3` as I did in the last post (interacting with some publicly-hosted servers), I chose to use the command-line tool provided by the good folks at [Ookla/speedtest.net](https://www.speedtest.net/). Many are familiar with their webpage-based tests and apps, but I was pleasntly surprised to learn of the [command-line version](https://www.speedtest.net/apps/cli), specifically because it allows me to generate results in `json` which is helpful for subsequent analysis. Additionally, they (Ookla) suggests that the non-browser-based versions (apps, commandline) provide more consistent results on higher-speed links. This seemed like just the solution for me.

## Methodology

My methodology and setup for this test is identical to the what I did for the local networking tests. I have the same test machines, configured the same way, and use the same test locations. Similarly, I test both wired and wireless connections. 

One concession I made to the realities of the Internet, is that I chose to perform my tests early on a Saturday morning, when (_presumably_) both my home network and general traffic on the Internet would be a little less congested. That said, the _primary objective_ is to get measurements for _comparative analysis_ (ordinal) rather than stand-alone analysis or value (cardinal). I should also mention that I spent some time testing different servers to see where I received good/consistent results and then explicitly selected that server for all of my tests.

For concreteness, the command I ran for each test was simply the following:

```bash
# Get a list of servers/ids that are near you:
# speedtest -L

# run the test/store the results in a JSON file
$ speedtest -s [server_id] -f json > [testname.json]
```

## Results

Just like with the internal network testing, we start our results with looking at the hard-wired connections. This provides the comparative baseline for understanding how well the wireless network is performing.

### Wired Network

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wired.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wired.png" alt="download and upload speeds - wired"></a>
  <figcaption>Figure 1: Download/Upload speeds (Wired) [click to enlarge]</figcaption>
</figure> 

The results here are about exactly what we would expect. The download speeds are significantly better than the upload speeds, and the measurements are reasonably consistent regardless of testing location. I have a 1 Gbps fiber connection and I've never seen download speeds much better than about 500 Mbps. While I'm not aware of what my upload speed is supposed to be, I've not seen it much more than about 30 Mbps. Our average download speed over these tests is 477.6 Mbps and upload is 29.9.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wired_rexmit.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wired_rexmit.png" alt="packet loss - wired"></a>
  <figcaption>Figure 2: Packet Loss Percentage (wired) [click to enlarge]</figcaption>
</figure> 

By contrast, the data in Figure 2 was a bit concerning. To have such high packet loss on the majority of the test measurements seems a bit extreme. I'm uncertain the cause of this but it will be interesting to see if the _post upgrade_ results are similar for wired connetions.

### Wireless Network

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless.png" alt="download/upload speeds by location - wireless"></a>
  <figcaption>Figure 3: Download/Upload speeds by location (wireless) [click to enlarge]</figcaption>
</figure> 

Figure 3 presents results that we would likely expect given the results of the network mapping and internal network speed tests. While all of the speeds are significantly lower than the wired tests, the performance drops off rapidly as one moves away from the center of the home. Specifically, the sunroom and bedroom 2 experience very poor transfer rates. The upload speed is rather consistent for most locations though it does drop off again for the two furthest spots. 

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless_ssid.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless_ssid.png" alt="wireless transfer speeds by location and SSID"></a>
  <figcaption>Figure 4: Wireless transfer speeds by location and SSID [click to enlarge]</figcaption>
</figure>

Breaking the results out by wireless network once again confirms what we would expect. While the general data rate trends remain consistent, the 5 Ghz networks perform significantly better than the 2 Ghz variants. As we saw with the internal network measurements, the 2 Ghz band on the primary network performs better than it should, leading me to question the actual isolation. Also, the newer AP performed better in most cases than the older (kids network), although the older device outperformed the newer in a few locations (kids bedrooms, sunroom).

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless_rexmit.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless_rexmit.png" alt="packet loss by location"></a>
  <figcaption>Figure 5: Packet loss by location (wireless) [click to enlarge]</figcaption>
</figure> 

The biggest take-away from Figure 5 is how much lower the packet loss was on the wireless tests as compared to the wired tests above. Here, the majority of the tests showed less than 6% loss.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless_rexmit_ssid.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wireless_rexmit_ssid.png" alt="Wireless packet loss by location and SSID"></a>
  <figcaption>Figure 6: Wireless packet loss by location and SSID [click to enlarge]</figcaption>
</figure> 

And breaking packet loss out by SSID we see that the majority of the loss was on the main 2 Ghz network and the kids 5 Ghz. The main 5 Ghz and kids 2 Ghz networks were quite consistent.

### Wired vs Wireless

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wired_vs_wireless.png"><img src="{{ site.url }}{{ site.baseurl }}/images/hn1_external_wired_vs_wireless.png" alt="transfer speeds by connection type"></a>
  <figcaption>Figure 7: Transfer speeds by connection type [click to enlarge]</figcaption>
</figure> 

Finally, we directly compare the two connection types here in Figure 7. The wired download speed averaged 477 Mbps compared to 173 on wireless (2.76 times better). The upload speeds were much closer at 29.9 and 24.3 respectively with wired being only a 20% improvement over wireless in this direction.

## Next Steps

Having clearly established the *before* state of the network environment in [the next post]({{ site.url }}{{ site.baseurl }}/technology/2021/03/05/fix-home-network-part-5/) we will document the equipment selected for the upgrade and the reasoning behind it. The following post will discuss the actual installation and configuration followed by performance measurements and comparisons.
