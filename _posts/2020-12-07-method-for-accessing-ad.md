---
layout: post
category: technology
title: 'Method for Assessment of Security-Relevant Settings in Anomaly-Based Intrusion Detection for Industrial Control Systems'
date: 2020-12-07 10:42
tags:
- vulnerability research
- studies
- ics
description: "Some of you know that a few months ago I mentioned that I had successfully defended my disseration. One of the things I did not do at that time, was to point to some of the work that both I and my team had done in getting to that point. This is the first in a series of posts that will introduce some of that work."
---

Some of you know that a few months ago I mentioned that I had [successfully defended my disseration](https://robgillen.com/technology/2020/09/24/today-i-did-a-thing/). One of the things I did not do at that time, was to point to some of the work that both I and my team had done in getting to that point. This is the first in a series of posts that will introduce some of that work.

The work that went into my dissertation is embodied in three papers that have been published via IEEE. The first establishes a simple model for assessing the effective security gained/lost by various configurations of ML-based anomaly detection systems desgined to protect industrial control systems. The second paper discusses the design methodology and implementation of a test bed required to validate the method described in the first paper. The third paper details the experiments and results of evaulating the method from the first paper via the testbed described in the second.

The title of the first paper is: _"Method for Assessment of Security-Relevant Settings in Anomaly-Based Intrusion Detection for Industrial Control Systems"_. I was the lead author and the paper was co-authored by my doctoral advisor, [Dr. Stephen L. Scott](https://www.tntech.edu/directory/engineering/faculty/stephen-scott.php).

The abstract is as follows:

> Ensuring the integrity of Ethernet-based networks is a challenging and constantly evolving domain. This problem is exacerbated for those operational technology (OT) networks supporting industrial control systems (ICS) since much of that equipment was originally designed to be on a network that was isolated and generally considered free of malefactors. Increasing pressure to bridge these systems with traditional information technology (IT) networks has introduced a bevy of new threats. In response, both academia and industry have responded with security solutions tailored to ICS environments. Deploying these protection systems often involves several configuration choices. While some of these choices are clear (e.g., block/enable protocol X) others are far more subjective (e.g. alert threshold == 3.43). Further complicating the situation, while often similar to IT networks, OT networks have unique challenges and characteristics that make the task of protecting them simultaneously more difficult and straight forward.Extant solutions for quantifying the relative security of intrusion detection systems fail to effectively support the operators of said systems with understanding the impact of various configuration changes. Further, they assume that the attacks are static and not subject to manipulation or alteration in the face of defenses. In this paper, we present a threat-based method for quantifying the relative impact of various security settings for intrusion detection systems (IDSs) within ICS environments. This method provides operational staff with a clear understanding of the relative impact of their settings and assumes that the attacks levied against them are dynamic. The model is described in detail, we apply the model to a synthetic data set, and discuss the inferences that can be made and what types of decisions they could be used to support.

The paper is availble at the following locations:

* [Official IEEE version](https://ieeexplore.ieee.org/document/9274691)
* [DOI: 10.1109/ICPS48405.2020.9274691](https://doi.org/10.1109/ICPS48405.2020.9274691)
