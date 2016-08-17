---
layout: post
category: technology
title: '“Live” Monitoring Of Your Worker Roles in Azure'
date: 2009-09-03 00:00
tags:
- cloud computing
- .net
- azure
- cloud
redirect_from:
- /blog/2009/9/3/live-monitoring-of-your-worker-roles-in-azure.html
---

<img alt='Azure Gugage' src='/images/azure_guage.png' class='blogimage img-responsive'>

I’ve been working for a bit on some larger-scale jobs targeting the Windows 
Azure platform and early last week had assembled a collection of worker roles 
that were supposed to be processing my datasets for a number of days moving 
forward. Unfortunately, they wouldn’t stay running. As always, they “worked on 
my machine”, so I naturally assumed that the problem was with the Azure 
platform :). I then proceeded to do what I thought was the correct action… go 
to the Azure portal and request that the logs be transferred to my storage 
account so I could review them and fix the problem. What I learned, is that 
there were two problems with this solution:

1. The time delay between requesting the logs and actually being able to review 
them is prohibitive for productive use. In my experience, the minimum turn 
around was 20 minutes and was most often 30 or longer. I’m not sure why this 
was happening – is this by design, or a temporary bug, or an artifact of the 
actual problem with my code, or what, but I know it was too long.

2. Logs appear to get “lost”. In my scenario, my worker roles were throwing an 
exception that was un-caught my by code. Near as I can tell, when this happens, 
the Azure health monitoring platform assumes that the world has come to an end, 
shuts down that instance, and spins a new instance. While this (health 
monitoring and auto-recovery) is a good thing, one side effect (_caveat is the 
fact that this is my experience and may not be reality_) is that the logs were 
stored locally and, when the instance was shutdown/recycled, those log files 
went to the great bit-bucket in the sky. I was stuck in a failure mode with no 
visibility as to what was going wrong nor how to fix it.

After pounding my head for a bit, I came up with the following solution – trap 
every exception possible and use queues. The first aspect allowed my worker 
roles to stay running. This may not always be the right answer, but for my use 
case, I adapted my code to handle the error cases and trapping / suppressing all 
exceptions proved to be a good answer. Further, doing so allowed me to grab the 
error message and do something interesting with it.

The second step (using queues) solved the (my) impatience problem. I created a 
local method called WriteToLog that did two things: write to the regular Azure 
log, and write to a queue I created called status (or something similarly 
brilliant). I replaced all of my “RoleManager.WriteToLog()” calls with calls to 
the local method and I then wrote a console app that would periodically (every 
few seconds) pop as many messages as it could (API-limited to 32) off of the 
status queue, dump the data as a local csv for logging and write the data to the 
screen. This allowed me to drastically reduce the feedback loop between my app 
and me, enabling me to fix the problems quickly.

There are certainly some downsides to this approach (do queues hit a max?, what 
is the overhead introduced by logging to a queue, once a message is dequeued, 
it is not available for other clients to read, etc), but it was a nice spot fix. 
A better implementation would have a flag in the config file or something 
similar that would control the queue-logging.

As you can see from the image above, I also wrote a little winform app to 
display the approximate queue length so I’d have an idea of the progress and 
how much work remained.
