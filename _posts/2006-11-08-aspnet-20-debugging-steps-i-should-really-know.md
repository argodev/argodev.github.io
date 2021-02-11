---
category: technology
title: 'ASP.NET 2.0 Debugging steps I should really know'
date: 2006-11-08 00:00
tags:
- general development
- asp.net
redirect_from:
- /blog/2006/11/8/aspnet-20-debugging-steps-i-should-really-know.html
---
As part of my "not-my-real-job" time, I do a little website hosting - basically to keep my hands dirty with the problem space and to increase my visibility into the windows hosting space. One of the sites we host updated their site this past week with a new CMS platform and the site failed to work. On the site owners development machine the site worked fine... on my dev/test machine the site worked fine but on the production server it failed every time.

On the production server, we kept getting the following error:

> A process serving application pool 'PublishTruth' suffered a fatal communication error with the World Wide Web Publishing Service. The process id was '3496'. The data field contains the error number.

After which the application pool would shut down in an effort to protect IIS from a faulty app (actually, it would shut down after a few attempts in a short period of time).

This began a lesson in advanced (well, maybe not terribly so) .NET debugging. We installed the IIS Debug tools and learned quite a bit about debug dumps and the tools and analysis options available to you at that level, but we still weren't learning anything... the errors were coming from standard .NET assemblies.

The "break" came when a colleague came across an [article](http://blogs.msdn.com/tess/archive/2006/04/27/584927.aspx) on [Tess Ferrandez's blog](http://blogs.msdn.com/tess). The kicker was the explanation of a substantial change between ASP.NET 1.0/1.1 and 2.0 as [described here](http://support.microsoft.com/?id=911816). The net-net is that in .NET 1.0 and 1.1, unhandled exceptions on managed threads were ignored. Unless you attached a debugger to catch the exception, you would not realize that anything was wrong. However, in .NET 2.0, when an unhandled exception in a managed thread occurs, __the asp.net application unexpectedly quits__.

I suppose that this is a good thing, in that I would likely have not found the problem without this "feature", however it can be frustrating if you have no good way to see the actual error that is occuring. Thankfully, the [MSDN post](http://support.microsoft.com/?id=911816) has a sample handler module that you can implement to catch such exceptions and log them and the stack to the event log. After implementing the sample code (specificaly a copy-paste from the article... I didn't have to change anything) I was able to see the error in the event log and quickly rectify the problem.

I now have a handly little handler module that I'll keep in my toolbox as a quick way to debug such problems combined with the knowledge of what is likely going on when my asp.net applications unexpectedly quit.
