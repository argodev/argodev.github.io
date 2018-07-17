---
layout: post
category: technology
title: 'Walkthrough: OpenACC For Programmers'
date: 2018-07-15 17:47
tags:
- books
- high performance computing
---

Time for another in my series of technology book walkthroughs. I've done one on [OpenCL 2.0](http://robgillen.com/technology/2017/12/19/heterogeneous-computing-opencl2/), [CUDA](http://robgillen.com/technology/2018/04/26/cuda-for-engineers/), and now this one on OpenACC. I chose OpenACC due to the fact that I'm currently leading a project that is C++ based and we are looking at various means of accelearating it using GPUs and multiple nodes. CUDA, while definitely appropriate, comes with a correspondingly high lift. OpenACC (on the surface at least) promises to ease one in to the accelerator space and to gracefully degrade back to a multi-core CPU if no CUDA-capable GPU is available. It is quite possible that OpenACC, in concert with OpenMP and OpenMPI may provide a strong solution to the scaling problems my team is working on.

As before, the book I've selected - _OpenACC for Programmers_ - is [available on Amazon](https://amzn.to/2vtNEZZ). The full writeup, notes, and source code [are on my Github Repo](https://github.com/argodev/learn/tree/master/books/openacc_programmers).