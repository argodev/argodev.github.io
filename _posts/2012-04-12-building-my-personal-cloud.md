---
category: technology
title: 'Building My Personal Cloud'
date: 2012-04-12 00:00
tags:
- cloud computing
- cloud
redirect_from:
- /blog/2012/4/12/building-my-personal-cloud.html
---

<figure class="align-center" style="width: 300px">
  <a href="{{ site.url }}{{ site.baseurl }}/images/78881z2p31zg232.jpg"><img src="{{ site.url }}{{ site.baseurl }}/images/78881z2p31zg232.jpg" alt="Cloud"></a>
  <figcaption>Image courtesy of Pixomar</figcaption>
</figure>

This is a bit of an odd post in that it is more a “wondering aloud” then anything specifically prescriptive or informative. I was asked yesterday by a student if I knew of a Windows box he could use to test something on. It was a simple request – he had been building an application on his Mac, and before handing it over to be used, wanted to validate that it worked on Windows. It had the one unique requirement that it had to run on our network at Work due to accessing some IP-restricted content.  The “official” answer was to have him contact our help desk and they would set him up, however the answers he got from them were (understandably) geared towards long-term use of a Windows “desktop”… and came with the associated costs (licenses, labor, etc.). What he really needed, was a VM running a trial version of Windows that he could use for two hours and then throw away… What he needed, was a place he could go, select a Windows machine from a catalog, click “go”, run for a few hours and then click “done” and have it go away… What he needed, was access to a cloud platform.

Unfortunately, I didn’t have a good answer for him, and am still a bit uncertain how he is going to go about fixing the issue, but it did get me thinking about what it would take to have/run a “personal” cloud… nothing fancy, but say I have a single “beefy” workstation/server and I’d like to have a thin hypervisor, and a web-based interface to provision/de-provision running instances… maybe setup a catalog virtual machines that I’ve used before as “starting points” for new machines. The platform should support a wide variety of OS choices… Windows and Linux without noticeable compromises for either. It would be nice if the platform could support various virtual networking (nothing fancy, but the ability, at times to create a private network that only two machines can talk on – for testing various things). The final two requirements are that it should support *modest* horizontal scaling (say, I add one or two new physical boxes) and it should be free (or very low cost). This is for personal use or a small group test platform… nothing fancy or official… just something that works. As soon as you get into anything significant cost-wise, you raise the attention of corporate IT, project budgets, etc. and your simple idea just ballooned into something with a budget line item, project managers, and no chance of coming to life.

Options/Solutions: The following is a list of some of the options I’ve been considering along with some commentary on each. I’d be very interested in feedback, but I would caveat that I don’t want the platform itself to be a research endeavor… it should basically “just work” out of the box and not require significant fiddling to get it stable/working.

* I have a leaning towards Microsoft products (mostly due to familiarity) so I considered them first, but quickly ruled them out. VirtualPC is not anything what I’m looking for, and HyperV /SystemCenterVMM / [insertManyMoreAcronymsHere] seems OK for a lager-scale deployment but seems like *way* too much overhead for what I’m looking for.

* Eucalyptus – This is a platform I’ve worked with in the past, and is amazingly easy to setup/run but its support for Windows platforms (at lest in my recollection) isn’t that great.

* VMWare Workstation has some interesting things, and to large degree, this would be my front-runner short of the fact that there is no web UI for a remote user to provision/interact with a machine. This solution works fairly well, however, for a single user directly interacting with the physical host. While not free, the cost seems reasonable enough (~$200).

* VMWare vSphere Essentials is promising, especially if used in conjunction with VMWare Workstation. It comes with a web-UI, can scale to multiple physical hosts, has broad OS support, and comes from, arguably, one of the longest-standing leaders in this space. It isn’t free, but at <$500, it falls in the reasonable category – esp. considering it supports up to three physical machines. The price does, however, tend to eliminate it from consideration for my home network.

* CloudStack + [nameYourHypervisor] – CloudStack is another interesting option and it certainly has a nice UI, however our recent experiences have shown that, while very powerful and great for building large cloud deployments, it seems a bit over-complicated for a one or two server installation. Further, we had significant issues with networking performance for our Windows machines (note: this may be an artifact of the hypervisor we chose: Citrix’s XenServer). Further, we found that there was significant amount of “tinkering” that had to be done to get it working… i.e. download patch X from this svn repo, only use version such-and-such of python, etc. Most of these issues may have been environmental and/or solvable by using other distros/hypervisors, but it was a non-trivial deployment.

* OpenStack – OpenStack seems to be what all of the cool kids are using these days, but our experiences once again hinted at a lack of maturity in the computing platform for the general sense (range of OS support) and the lack of a solid web-UI eliminates it from consideration.

* XenServer – Another option I considered briefly is to use the free XenServer and then the windows desktop client to manage the servers and create new images/machines. This would work (we are actually doing this in one of our lab environments) but fails the self-provisioning portion of the exercise (no web-based portal, etc). Additionally, we’ve had issues with the networking stack for non-Linux machines and have spent a large amount of time tracking down driver issues and performance issues.

At this point, I don’t have a solution… I’m still looking, and am guessing that whatever I end up with will require an amount of compromise. Comments/suggestions are welcome…
