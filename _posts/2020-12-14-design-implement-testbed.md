---
layout: post
category: technology
title: 'Design and Implementation of Full-Scale Industrial Control System Test Bed for Assessing Cyber-Security Defenses'
date: 2020-12-14 10:42
tags:
- vulnerability research
- studies
- ics
description: "Last week, I wrote about the first paper in a series of three that summarize the work my team did on assessing anomaly detection methods for protecting industrial control systems. In this post, I introduce the second paper published by the IEEE. This paper discusses the design methodology and implementation of a test bed required to validate the method described in the first paper. The third paper details the experiments and results of evaulating the method from the first paper via the testbed described in the second."
---

Last week, I wrote about [the first paper](https://robgillen.com/technology/2020/12/07/method-for-accessing-ad/) in a series of three that summarize the work my team did on assessing anomaly detection methods for protecting industrial control systems. In this post, I introduce the second paper published by [the IEEE](https://www.ieee.org/). This paper discusses the design methodology and implementation of a test bed required to validate the method described in [the first paper](https://robgillen.com/technology/2020/12/07/method-for-accessing-ad/). The third paper details the experiments and results of evaulating the method from the first paper via the testbed described in the second.

The title of this paper is: _"Design and Implementation of Full-Scale Industrial Control System Test Bed for Assessing Cyber-Security Defenses"_. I was the lead author and the paper was co-authored by [Laura Ann Anderson](https://www.ornl.gov/staff-profile/laura-anderson), [Chris Craig](https://www.linkedin.com/in/chris-craig-47250024/), [Jordan Johnson](https://www.linkedin.com/in/jordan-johnson-993009141/), [Andrew Craig](https://www.linkedin.com/in/andrew-craig-426766118/), [Adam Columbia](https://www.linkedin.com/in/adam-columbia-95329a15a/), Rachel Anderson, and my doctoral advisor, [Dr. Stephen L. Scott](https://www.tntech.edu/directory/engineering/faculty/stephen-scott.php).

The abstract is as follows:

> In response to the increasing awareness of the Ethernet-based threat surface of industrial control systems (ICS), both the research and commercial communities are responding with ICS-specific security solutions. Unfortunately, many of the properties of ICS environments that contribute to the extent of this threat surface (e.g. age of devices, inability or unwillingness to patch, criticality of the system) similarly prevent the proper testing and evaluation of these security solutions. Production environments are often too fragile to introduce unvetted technology and most organizations lack test environments that are sufficiently consistent with production to yield actionable results. Cost and space requirements prevent the creation of mirrored physical environments leading many to look towards simulation or virtualization. Examples in literature provide various approaches to building ICS test beds, though most of these suffer from a lack of realism due to contrived scenarios, synthetic data and other compromises. In this paper, we provide a design methodology for building highly realistic ICS test beds for validating cybersecurity defenses. We then apply that methodology to the design and building of a specific test bed and describe the results and experimental use cases.

The paper is availble at the following locations:

* [Official IEEE version](https://ieeexplore.ieee.org/document/9217693)
* [DOI: 10.1109/WoWMoM49955.2020.00064](https://doi.org/10.1109/WoWMoM49955.2020.00064)
* [DOE Office of Scientific and Technical Information (full text)](https://www.osti.gov/biblio/1684697-design-implementation-full-scale-industrial-control-system-test-bed-assessing-cyber-security-defenses)

Here's a few pictures of the testbed:

![TestBed](/images/laboverview.png)

![Back Side](/images/backside.jpg)



