---
layout: post
category: technology
title: 'Packet Processing'
date: 2019-11-04 19:37
tags:
- vulnerability research
- studies
- ics
description: 'Over the past few weeks I have been working on analyzing a series of `pcap`
captures. These files represent the communication between a number of industrial
control devices such as variable frequency drives (VFDs), a historian, a
human-machine interface (HMI) and a programmable logic controller (PLC). The
data is Ethernet/IP and CIP (Common Idustrial Protocol). For those who may not
be aware, ENIP+CIP is essentially an ICS protocol that is transported over
standard Ethernet packets as the payload for either TCP or UDP packets.'
---

Over the past few weeks I have been working on analyzing a series of `pcap`
captures. These files represent the communication between a number of industrial
control devices such as variable frequency drives (VFDs), a historian, a
human-machine interface (HMI) and a programmable logic controller (PLC). The
data is Ethernet/IP and CIP (Common Idustrial Protocol). For those who may not
be aware, ENIP+CIP is essentially an ICS protocol that is transported over
standard Ethernet packets as the payload for either TCP or UDP packets. 

## Data Volume

The data I am analyzing is not trivial, but it isn't incredibly "big" either. I
have 64 days worth of data, and the captures are broken up into 60-minute
chunks. Each of these files averages 5.8 million packets. This brings my total
data set to something just shy of 9 billion packets. 

## Analysis Platform

I'm going to be discussing performance numbers, and this means I need to explain
the platform from which they are taken. I have a machine at work that is a
realatively old HP server with a bunch of 7200 RPM disks in a RAID
configuration. The machine has 24 cores and 192 GB of RAM. It is really nothing
special and I think it's approximately 6 or 7 years old at this point. What I
like about it, is that I can store a bunch of data on it, add some code, and let
it run for days or weeks while continuing to do other work on my main
workstation.

## The Problem

The 'analysis' I am doing consists of looking across all of the capture files,
applying some filter for various subsets of the packets, and then parsing the
packet contents to pull out various bits of data from which I can answer
questions and generate additional inquiries. Because this is research work and
not a production system, I wrote my first version in the data-researcher
language-of-choice: Python. The most common library currently in use (at least,
as it appears from my digging), is [__SCAPY__](https://scapy.net/). SCAPY does a
*ton* of different packet manipulation tasks and is particularly good at
crafting and sending packets on the fly. It is very clear and easy to implement
your own "layers" for various protocols and I was able (with the help of a
colleague), to get up-and-running with a ENIP/CIP packet-parsing script rather
quickly.

The problem was, it was slow. Not just a little slow, __*really*__ slow. But, it
was deceptive. Working on a small `pcap` file with a few dozen packets in it, it
was great. However, when I released it on one of the hour-long files, it took
forever. When I moved it from my brand-new development workstation to the
analysis machine that houses the bulk of my data, the performance went out the
window. To give context, looping through one file (60 minutes worth of data),
parsing it to find a small subset of packets that represented a specific CIP
interaction (~700 packets out of 5,800,000), took *over three hours*. I haven't
done a ton of packet-level work recently, but this didn't feel right. I got to
wondering if the convenience features of SCAPY were adding too much overhead at
the packet volume I was looking at... especially since I was simply doing
dissection and not creation. 

## Attempt #2: DPKT

My next attempt was to use [`dpkt`](https://github.com/kbandla/dpkt). This is a
lower-level python library that can be used to dissect packets. The way in which
you build a dissector for non-standard layers (the `ENIP` and `CIP` layers) is not
nearly as friendly as the `SCAPY` approach (mostly `struct.unpack()`), but it
wasn't too bad. Producing the same analysis using `dpkt` and `struct.unpack()`
took roughly a day to flesh out, test, and validate. The performance benefit was
immediately obvious as the runtime per file dropped to just over four minutes. I
probably should have been happy with this result (I was) and just stopped, but I
kept wondering if that was the best I could do (within reason, of course).

## Attempt #3: Golang

One of my colleagues was berating me today for not jumping immediately to `c` or
`c++`, but I have an irrational resistance to those languages (this will
probably change some day). Instead, I decided to give the
[`go`](https://golang.org/) programming language a shot. Prior to this point I
had no experience with the platform other than knowing that another colleague
was a big fan and it was supposed to give you many of the performance benefits
of a C-like language with the memory-saftey of more modern languages.

I was pleasently surprised to find that with just over a full day's worth of
effort, I was able to go from not ever having written a line of `go` code to
having a running program that had both logic and feature parity with my
python-based scripts. What really surprised me was the runtime. On my
development machine with small capture files, I was analyzing 12,000 packets in
under 100ms. Testing it on my main analysis machine with a few representative
files showed yet additional performance improvement over the `dpkt` version with
this program completing in just under 30 seconds.

## Results

If you took the time to read the text above, you already know the results, but
for the `tl;dr;` crowd, I've included a few charts and a summary.

For my purposes (packet dissection), on my analysis machine, the `go` program
finished the analysis in just under 30 seconds compared to 3-4 minutes for the
`dpkt` version and over 3 _hours_ for the `scapy` script. For those wondering, I
ran the scripts a handful of times and also with different files to ensure I
wasn't seeing system anomalies. I also ran them on different machines. While the
numbers were different based on the machine (different processors, hard drives),
the ratios between the approaches remained constant.

<img alt='Seconds per File' src='/images/secondsperfile.webp' class='blogimage img-responsive'>

<img alt='Packets per Second' src='/images/packetspersecond.webp' class='blogimage img-responsive'>

In the end, the `go` program allows me to analyze the entire data set in
approximately 32 minutes compared to over 8 days for the `scapy` script. As you
can see in the lower figure, the scapy-based script was able to process at a
rate of 510 packets/second (PPS) whereas the golang program ran at 193,821 PPS. 
On newer hardware with faster drives, the PPS rate nearly doubled, but the ratio 
held.  I think I will be honing my `go` skills...


## Lessons Learned

1. If you are going to use `scapy` with large packet files, consider using the
   `PcapReader` interface rather than the `rdpcap()`. Most of the examples I
   found online used `rdpcap` but this appears to read the entire file into
   memory prior to letting you process the individual packets. This also can
   cause memory issues. The `PcapReader` approach gives you an iterator and you
   can work with each packet as it is `yielded`. 

1. While it is probably obvious, extra "friendliness"/verbosity is often the enemy of
   performance (though not always). 

1. It is hard to beat the performance of a compiled language.
