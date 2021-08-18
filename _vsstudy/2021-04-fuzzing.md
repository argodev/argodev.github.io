---
title: "Fuzzing"
permalink: /vsstudy/fuzzing/
excerpt: "Resources, Tutorials and Tips for fuzzing software"
last_modified_at: 2021-08-18
published: True
toc: true
---

## Introduction

Originally, I had planned to work on this topic much later in the year, but due to some project needs, I ended up spending quite a bit more time on this earlier in the year than expected. Further, the "learning" aspect of this has been much less _contained_ than I would have expected. Meaning, I've done a fair bit of fuzzing over the last few months, and have experienced varying levels of success, yet I believe that I have quite a long way to go before I've _"mastered"_ anything. 


## Books of Interest

I've not read many books on this topic. It seems that the general space is moving fast enough that the current "state of the art" is well ahead of the pace of traditional publishing methods. That said, there are some books available.

- [The Fuzzing Book](https://www.fuzzingbook.org/); Zeller, Gopinath, Bohme, Fraser, and Holler. This is a web based "book", that introduces you to a number of different concepts within the broader scope of software fuzzing. I didn't follow this book in its entirety, but it serves as a good "reference" on some of the topics and general techniques relative to fuzzing. It can be used as material for an actual course and is quite well developed. If you find this interesting, you may also be interested in another resource assembled by Zeller, [The Debugging Book](https://www.debuggingbook.org/).


## Videos of Interest

- [Intro to Exploit Development: Fuzzing with AFL](https://www.youtube.com/watch?v=3Kc_joW2YgM)
- [Fuzzing for Beginners](https://www.youtube.com/watch?v=O3hb6HV1ZQo&t=1400s)
- [LiveOverflow: Fuzzing Sudo series](https://www.youtube.com/playlist?list=PLhixgUqwRTjy0gMuT4C3bmjeZjuNQyqdx)
- [Awesome Fuzzing List Video Links](https://github.com/secfigo/Awesome-Fuzzing#videos)

## Tutorials

- [Google's libfuzzer tutorial](https://github.com/google/fuzzing/blob/master/tutorial/libFuzzerTutorial.md)
- [Structure-Aware Fuzzing](https://github.com/google/fuzzing/blob/master/docs/structure-aware-fuzzing.md)
- [AFL++ Tutorials](https://aflplus.plus/docs/tutorials/)
- [Klee Tutorials](https://klee.github.io/tutorials/)

## Miscellany

### Tools Utilized

There are many fuzzing approaches available... everything from home-grown scripts to complete platforms. To date, I've utilized the following tools:

- [`libfuzzer` (part of LLVM)](https://www.llvm.org/docs/LibFuzzer.html)
- [AFL (American Fuzzy Lop)](https://lcamtuf.coredump.cx/afl/)
- [AFL++](https://aflplus.plus/)
- [Klee](https://klee.github.io/)


### Fuzzing Isolation

One of the lessons I learned while working on a fuzzing target is the importance of considering the isolation (or lack thereof) of your fuzz targets. In one case, I had built and run what I thought was a straight-forward/limited scope fuzz target. I tested it on my main machine and everything was working well... I was seeing code coverage increase, my execution rate was high, and CPU utilization was strong. I then moved the fuzz harness to my "production" fuzz machine and instantly saw the performance of my fuzzer _drop_. And not just by a little... it was over an order of magnitude slower in executions/sec and the system processors were sleeping. While trying a number of things, at one point I disabled the network interface and my performance immediately skyrocketed. Through the process of debugging, I learned that the software I was fuzzing had the ability, in certain cases, to make DNS calls. In my initial development environment, the DNS server was available/local so resolutions occurred quite quickly. In my production fuzzing system, DNS was not available (or not properly configured), so it kept attempting to forward DNS queries for fuzzed domain names (unlikely to ever resolve) to unreachable root DNS servers. Only once each request timed out would the test return. I eventually fixed the fuzz harness so it neither timed out nor did it flood our DNS server with worthless queries. 

### Vagrant/Ansible

While working on my fuzzing targets, I regularly ran into situations wherein the target binary/code needed to be compiled on a specific OS or even platform architecture. Spending time thinking through how to do this well, and how to scale it (across a team) such that every researcher didn't have to "reinvent the wheel" led me down the path of investigating a combination of Vagrant and Ansible as initial fuzzing platforms. As is likely not a surprise to anyone who has used these tools, the solution was actually quite sound, leaving me with a collection of text-base environment "definitions" that I could store in a source tree and others could execute, giving them a similarly configured environment as I used. The only problem was the weight of the resultant platform - some large number of full virtual machines. For emulation and other architectures this will likely be my path forward, but it feels a bit too heavy for "normal" `x86_64` based software.

### Docker for Fuzzing

This led me to consider using docker containers as my custom fuzzing environments. Dockerfiles, combined with some scripts and configuration can yield some of the same benefits as the vagrant/ansible option, yet produce smaller/lighter-weight execution environments. I currently have a few fuzz targets running in this configuration and am looking forward to further testing.

### Future/On-Going Work

There are a number of things I'm still working on and hope to expand my understanding in this area. One of the main ones is structure-aware fuzzing. I've provided a link to a structure-aware fuzzing intro in the tutorial section above. I've done some initial work with this, but need to expand my work in this area.
Structured Fuzzing


