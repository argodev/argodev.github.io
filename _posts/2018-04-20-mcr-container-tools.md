---
layout: post
category: technology
title: 'MATLAB MCR Docker Image Tools'
date: 2018-04-20 17:47
tags:
- open source
- high performance computing
---

The team I work on at [ORNL](https://www.ornl.gov/) has been working on a shared data analytics platform (more soon) that is customized for a handful of specific use cases. One of the requirements is that we accept pre-compiled analytic routines and can execute them on the platform. One of the candidate compilers is the [Mathworks' MATLAB Compiler](https://www.mathworks.com/products/compiler/matlab-runtime.html) which targets the MATLAB Runtime.

One of the issues we have had is that the MCR does a poor job of helping you know what dependencies exist for your MCR-compiled executeable. This makes portablity a bit of a game of chance. To address this, our team is releasing (open source) our [mcr-container-tools project](https://github.com/ORNL/mcr-container-tools). This a set of CentOS 7-based Docker images and a Docker Compose YAML script for a simulated Slurm-driven compute cluster that can execute compiled MATLAB binaries via the MATLAB Runtime, facilitating a subset of the features of the MATLAB Distributed Computing Server without the expense. The dependencies listed in the Docker images' YUM calls can be used to deploy the (undocumented) dependencies for native installs of MATLAB and the MATLAB runtime in RHEL derived Linux distributions. The included scripts, which were used to determine the dependencies of the MCR's ELFs, can also be used to determine which CentOS packages contain dependencies for a given ELF application.

This is, admittedly, a niche application space, but for those who need it, hopefully it will be a help. As always, I'd like to fully acknowledge my team and [refer you to the official write-up](https://www.osti.gov/biblio/1429980-mcr-container-tools).

If you utilize these tools in any of your applications or scientific papers, we would appreciate a reference. The BibTex is below:

```text
@misc{osti_1429980,
    title = {MCR Container Tools, Version 00},
    author = {Haas, Nicholas Q and Gillen, Robert E and Karnowski, Thomas P},
    url = {https://www.osti.gov//servlets/purl/1429980},
    doi = {},
    year = {2018},
    month = {1}
}
```