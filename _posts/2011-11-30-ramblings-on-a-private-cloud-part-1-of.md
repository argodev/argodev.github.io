---
layout: post
category: technology
title: 'Ramblings on a Private Cloud (part 1 of ?)'
date: 2011-11-30 00:00
tags:
- cloud computing
- cloudstack
- private cloud
- xen
- xen center
redirect_from:
- /blog/2011/11/30/ramblings-on-a-private-cloud-part-1-of.html
---
As many of you are aware, a few months ago I changed jobs (more like positions) and with that change has come a shift
in the focus of much of my work. I’m spending less time in the abstract (i.e. “how could we solve problem X" in the
cloud”) and working more in the concrete (“we have agency Y that has problem X that needs to be deployed in the cloud
yesterday… what do you think?”). One unfortunate (at least in my way of thinking) is that many of these projects have
legislative requirements that prohibit the use of public cloud platforms (at least currently). While I’m always
looking for ways to avoid building individual, private “Cirrus<sup>1</sup>” clouds, and I remain hopeful that the day will come
when we all can leave the infrastructure build-outs to someone else, the reality is that in today’s world there is
some data that simply cannot live outside of an organization’s boundaries – leaving us to look at “private cloud”
approaches.

### Overview

We have been experimenting with a few different approaches for some of the projects I’ve been working on and are
learning a number of interesting things. I want to be quick to say that I don’t think we’ve “arrived” by any stretch
of the imagination and our work (and this space in general) is changing/evolving rapidly. Our initial requirements
included using free/OSS solutions wherever possible and to, as much as possible, avoid vendor lock-in (always great
in theory, frequently falls apart in application). The hardware used for this exercise includes 45 physical nodes
spread over two racks with a total of 1160 cores, 3.8 TB of RAM, 200 TB (RAW) of local node storage and 288 TB
(RAW) of iSCSI-connected storage. Our plan is to provide 8 VLANS across the environment (Management, Dev, Test,
Prod + corresponding disk-traffic networks for each). The physical nodes/nics would all default to the management
network and all of the actual compute resources (VMs used by researchers) would live in one of the other three
zones (Dev/Test/Prod). For reasons that I won’t get to in this post, we standardized on [CentOS](http://centos.org/) for the primary OS
and [Xen](http://xen.org/) as the target hypervisor. While some of the uses of the platform include data serving (i.e. web sites, data
services, etc.), most of the workloads will tend to be heavy data analytics. The above scenario is complicated by
the fact that the entire environment needed to be air-gapped (i.e. not connected to the Internet or other networks
in any way).

### Open Stack

While we have a good bit of experience using [Eucalyptus](http://www.eucalyptus.com/) on the Ubuntu stack, our
initial plan was to go with the current wisdom of the crowds and deploy [OpenStack](http://openstack.com/) as our
cloud orchestration layer. The intent was to buy in fully and deploy their storage, image, and compute services.
Unfortunately, while there are some very interesting things happening in this realm, we didn’t find this toolset
to be at the level we needed it to be given our platform selections. After a few weeks of trying to get this
working, we bailed due to simply needing to get something working<sup>2</sup>. We are hopeful that this situation
will evolve in the future and we will reconsider down the road, but for the present we had to scrap it and move on.

### Refactoring / Current Approach

Having burned a bit of our grace period, we were faced with the need to get something running fast and spent a
weekend digging through our options. Where we ended up is using the free
[XenServer](http://www.citrix.com/English/ps2/products/product.asp?contentID=683148) (via Citrix Systems) as the
host OS in combination with [XenCenter](http://community.citrix.com/xencenter) for managing the nodes. This –
while not a cloud or cloud orchestration layer – allowed us to quickly meet some of our sponsor’s needs while
buying some time to fill in the gaps. Our team is currently evaluating [CloudStack](http://cloudstack.org/) as
the cloud/orchestration layer to sit on top of XenServer and be the researcher-facing interface to the platform.
Our hope is that as the story evolves (Citrix, XenServer, XenCenter, CloudStack, OpenStack, etc) that the
deployment of future platforms will become easier and the “best” approach will become clearer.

<img alt='XenCenter' src='/images/xencenter.png' class='blogimage img-responsive'>

<small>XenCenter management console. Image credit Citrix Systems (<http://community.citrix.com/display/xs/XenCenter>)</small>


##### Notes
1. I spent a good bit of time looking on the web for the official name of the tiniest cloud but didn’t come up
with anything better than “Cirrus” which is defined as a “[thin, wispy cloud](http://en.wikipedia.org/wiki/Cirrus_cloud).”
Not exactly what I was looking for, but I’ll use it for now.

2. Our issues included (among other things) Python version conflicts between what OpenStack needed and the
version of Centos (5.6) we were running, the lack of a good Web UI/self-service portal, getting the VLANS
talking properly between hosts, vhosts, storage, etc., and a number of smaller miscellaneous items.
