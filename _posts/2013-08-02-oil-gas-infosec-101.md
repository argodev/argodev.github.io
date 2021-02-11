---
category: technology
title: 'Oil & Gas Infosec 101'
date: 2013-08-02 00:00
tags:
- conferences
- security
- defcon
redirect_from:
- /blog/2013/8/2/oil-gas-infosec-101.html
---

This talk was from a seasoned security professional working in the Oil & Gas industry (18+ years). It was by no means a terribly dramatic presentation, and the speaker was sort of "finding his way", however I found the talk very educational. He identified a number of ways in which early assumptions were made when the technology landscape was more innocent, and how these assumptions are now the source of significant risks.

To strengthen his point, he highlighted two historical cases wherein O&G folks had been targeted:

1. [Spear Phishing attack on Natural Gas Operators](http://www.infosecurity-magazine.com/view/25655/natural-gas-pipelines-targeted-by-cyber-attack/)
2. [The Saudi Aramco attack](http://www.bloomberg.com/news/2012-12-09/saudi-arabia-says-aramco-cyberattack-came-from-foreign-states.html) wherein 30,000 computers were compromised (MBRs were wiped)

He showed a number of pictures of different types of gear that would be forward-deployed and the types of communication and technology gear on each. One issue he mentioned was the need for high-security technology in a physically insecure environment. For example, you have a wide-spread physical area such as the following:

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/640px-YatesOilfieldNASA.jpg"><img src="{{ site.url }}{{ site.baseurl }}/images/640px-YatesOilfieldNASA.jpg" alt="Oil Field"></a>
</figure>

Where the oil field spans many square miles and each white dot represents a piece of equipment that has to report data back to centralized collectors.

Many of the talks I've heard recently in this general subject area have been focused on the electric grid, so it was interesting to hear it from the perspective of the O&G guys. Not surprisingly, many of the same issues apply. Comms can be over serial, microwave, licensed/unlicensed radio, 802.1x and is often not encrypted. Much of the gear has default passwords - he even hinted that some of the gear doesn't allow you to change the passwords...

Some of the technology is SCADA, but not all. That which is, is susceptible to the same types of attacks that we have heard about in the SCADA field for other fields. Frankly, the gear that doesn't talk SCADA is susceptible to the same types of attacks, just using different protocols.

Much like the other industries, the O&G field is vulnerable to attacks where "small" attacks can have long-term consequences... a mis-configured (i.e. hacked) pump/valve could cause an explosion... leading to damage of physical life, as well as damage of long-lead-time equipment meaning that the small event (time-wise) could cause an outage/reduction in capabilities lasting months if not longer.

Other systems of interest include the toxic chemicals/public health monitoring tools. Evidently they have systems that monitor the fields for emissions of gasses and chemicals (i.e. sulfide) that could be severely harmful to human life and, if detected/alarmed, begins the process of evacuation of the affected areas. One can imagine how much trouble this could cause if the alerts were falsely triggered.

The speaker did a good job of talking about how one might begin to secure the environments... non-flat networks, broadcast ACLs, etc. He indicated that in one case a piece of equipment failed due to a mis-configured router/switch that was allowing broadcast traffic from the corporate network to spill over onto the control systems network. Incidentally, he hinted that one of the biggest problems is that "we can no longer air-gap the networks" - not for technical reasons, but due to management's requirements that they be able to monitor/control these systems from their mobile devices, or their desk in the office, or whatever. The classic convenience vs. security trade off...
