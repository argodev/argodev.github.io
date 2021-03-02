---
permalink: /sane/
title: "Walkthrough: SANE and House of Force"
excerpt: "Minimal Mistakes is a flexible two-column Jekyll theme."
toc: true

modified: 2021-02-10T11:09:00-05:00
---

This post is part of a series of vulnerability walk-throughs that I am studying as part of my effot to be a craftsman in vulnerability science. *None* of this work is my own (see credits below) - the purpose of this write-up is to force me to get the the level of understanding with the issue that I can clearly explain it to someone else. It is only then that I feel like I can say I "get it". Even here, much of this work was initially assembled by a colleage of mine and I simply followed behind to further force my understanding of things.

## Overview

[SANE - Scanner Access Now Easy](http://www.sane-project.org/) is the scanning software built in to many modern distributions of Linux, most noteably maybe is the [Ubuntu Desktop](https://ubuntu.com/desktop). This suggests that when [GitHub's Security Lab](https://securitylab.github.com/) found [*multiple vulnerabilities* in a specific version](https://gitlab.com/sane-project/backends/-/issues/279), it could cause some issues. Of course, they disclosed them responsibly and they were addressed by the package maintainer. This vulnerability writeup caught my attention particularly because of the use of the [House of Force technique](https://seclists.org/bugtraq/2005/Oct/118) in the exploitation chain. This is a very old technique (> 15 years), but still remains usable through glibc 2.27 (shipped with Ubuntu 18.04 LTS) [it was addressed in 2.28].

### House of Force

It is likely not the best use of time/space for me to re-hash the details of the House of Force technique, but let me point to both the [original Malloc Maleficarum](https://seclists.org/bugtraq/2005/Oct/118) as well as the GitHub security lab's [writeup](https://securitylab.github.com/research/last-orders-at-the-house-of-force). If you learn better by watching, I'd point you to the first 30 minutes of this [Heaplab Taster by Max Kamper](https://www.youtube.com/watch?v=s-GJ-buCGio). Incidently, Max does a number of heap-specific training courses and, if you get the chance, they are well worth your time and money.

A quick summary of the technique is as follows:

1. You need to have an overflow/ability to write over the heap's `top_chunk` size field.
1. A common way to do this is to find a heap-overflow vunlnerability, then groom the heap so the object that you can overflow is at the end of the heap (right up against the top-chunk).
1. Overwrite the `size` field of the `top_chunk` with a very large value... something large enough to wrap around the VA (virtual address) space.
1. Make a very large allocation... something that puts fills nearly all of the space in the top chunk, but stops just before (`0x20`) the location you care to overwrite.
1. Make another allocation of an appropriate size and now you have control of your target space.

**ProTip:** If you made it here and are going _"huh???"_, I really recommend you check out [Max's video](https://www.youtube.com/watch?v=s-GJ-buCGio)... it's 30 minutes long and will clearly explain and demonstrate this technique.
{: .notice--info}

### Vulnerability issue.

asdfasd

