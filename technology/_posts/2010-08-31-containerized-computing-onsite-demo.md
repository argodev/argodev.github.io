---
layout: post
category: technology
title: 'Containerized Computing: Onsite Demo'
date: 2010-08-31 00:00
tags:
- cloud computing
- azure
- storage
---

As part of our cloud computing initiative we have been investigating the use of containerized computing and exploring if 
and where it might play a role in the computational environment where I work. In the context of this effort I have had 
the privilege of visiting a few different locations and seeing the containers first hand - an experience which has both 
answered and generated a number of questions for me.

<img alt='icecube' src='/images/header_icecube.jpg' class='blogimage img-responsive'>

We have a unique opportunity in that the SGI ICE Cube demo truck is going to be on-site here Thursday and Friday 
September 9th and 10th. During that time the container will be available both for walk-in traffic as well as 
pre-scheduled, in-depth presentations. While there are a handful of different container vendors and approaches, seeing 
one in person will give you a baseline and framework by which to analyze others.

For those of you not familiar with containerized computing, it (as an approach/concept, not necessarily this particular 
design) is being used in some of the largest datacenters being built and is a key component in Microsoft’s 3rd and 4th 
generation datacenter designs.

Some interesting characteristics of the SGI design (other vendors have other distinguishing features although there are 
some common threads such as high density, energy efficiency, etc):

- Provide the ability to operate at elevated temperatures (ambient – cold aisle - air of 85F)
- Incredibly high density, surpassing 46,080 cores within one container
- Reduced cooling cost
- 20’ or 40’ containers, can be stacked 3 to 5 high
- Dual row, universal and air-cooled designs
- Can contain compute, storage, network, and cooling
- Just plug in power, network, and chilled water (if needed)

SGI has recently added to their suite of designs a totally air cooled unit that simply requires a garden hose for 
intake water (read: “massive energy savings”).

More information on the SGI container can be found here: [http://www.sgi.com/products/data_center/ice_cube/] and a PDF 
datasheet is here: [Datasheet PDF](http://www.sgi.com/pdfs/4160.pdf)

If any of you live near where I work, and are interested in seeing this in person, contact me and I’ll see what I can 
work out (note: you must be a US citizen).
