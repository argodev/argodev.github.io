---
layout: post
category: technology
title: '.NET is a Smorgasbord?'
date: 2008-11-26 00:00
tags:
- general development
- .net
- wcf
- wpf
redirect_from:
- /blog/2008/11/26/net-is-a-smorgasbord.html
---
Like many other .NET devs I often find myself expecting to be current in all of the existing and up-coming tools/technologies in the Microsoft/.NET platform. Frankly, I don't know how that is possible, especially with the pace at which MSFT (not to mention the surrounding ecosystem) is releasing tools and platforms. Over the past few years, my approach has been to know "enough" about the various tools/technologies so that I can be conversant, and also know when a particular toolset applies to my current project, thereby warranting a "deeper" dive into that area. Such has been the case for me with WPF and WCF (much of my work over the past while has been in the SharePoint/web space meaning WPF - until SilverLight - didn't have much of a play and we hadn't yet seen a need to switch from standard ASMX for our services). They fell into the bucket of tools I had seen while walking along the smorgasboard, but I simply hadn't decided I needed to consume them yet. 

Scott Hansleman describes the .NET Framework and the MSFT tool suite as making it easy to "fall into success" (I'm sure I'm not quoting him correctly, but the idea is the same). Essentially, the tool set, while robust and quite capable, is approachable and relatively easy to simply build something. Especially when you compare it to other languages such as C++ -- in C#/.NET it is relatively easy to build "okay" code, and not that hard to build good code and almost (yes, there are plenty of exceptions) hard to write *bad* code. It is much easier (at least in my opinion) to write bad C/C++ code and much harder to write good C/C++ .code. I agree with him 100% - once you have a core competency on the platform, picking up the basics of the "new" stuff becomes almost trivial

I was recently working on a project (someone else did most of the coding - I did some of the design and proof-of-concept work) and I was able to see this in action. We were building a security-focused app, being deployed to a mixed environment of XP and Vista machines, and we had a 6-7 week window to build it, test it, and have it deployed. We ended up building a Windows Service that hosted a WCF service, a desktop application using WPF, a webpart for SharePoint and an IIS-hosted WCF service. We made heavy use of the cryptography libraries which, oddly (to me) were one of the areas that the other developer had prior experience with, however neither he nor I had done any real work with WCF and WPF. The technologies offered us quite a bit as far as functionality and form, even for two guys who weren't "experts" in them - that's where the "magic" lies - I'm reasonably comfortable with the MSFT dev stack, and I'm handed two completely new-to-me technologies, and with a relatively small amount of effort, I'm able to use them in my application and reap the benefits they bring. Now, certainly there's quite a bit more functionality that WPF/WCF bring to the table than what we used or "grok'd" during this project, but it did what we needed to and quickly - making me want to dig further into those technologies and to use them for other projects. 
