---
layout: post
category: technology
title: 'Big Data 101: Handling Millions of Files'
date: 2013-02-02 00:00
tags:
- theory
- big data
---
I've been talking a bit recently with members of my team about some of the basic tools that need to be in any data
scientist's toolbox. Things that, if you want to lay any claim to working with "big data" should be second nature. Many
of these things are not terribly complicated, nor does one have to be overly clever to employ them - however the lack
of knowledge as to when to properly apply them could cost you dearly (lost time, lost data, needless system
maintenance, etc.).

The first such topic came up a week or so ago when one of our younger team members mentioned that his machine fell over
after he had written around 3,000,000 files to the same directory. This reminded me of a lesson I learned back in late
2000 when I was working with Microsoft on the "Million Mailbox March" and the MCIS mail platform. MCIS contained a mail
platform designed by Microsoft for the ISP industry (later replaced by Exchange). This mail platform used an interesting
approach to store the potentially millions of mailboxes it housed on the file system. Similar approaches can be (and
often have been) applied to modern day storage problems within the Big Data space.

So, I came up with the following exercise/challenge for my students and colleagues - I hope you find it interesting. If
you've faced a similar problem in the past, you are likely jumping to solutions and know exactly how you would solve it.
It will be interesting to see the solutions presented by our team. I'll post any particularly interesting ones here.

Challenge #1: Handling Millions of Files.
Design and implement a solution for storing 100,000,000 files on a "normal" file system (NTFS, ext4, etc.). The
solution should be tested/verified and should be reasonably balanced. The system should provide a naming convention
that ensures against collisions. The solution should function properly on Windows, Mac and Linux. Finally, you need to
be able to explain the reasoning behind each design decision implemented in your solution.

Deliverables:

* A short write-up defining your approach and any incremental steps along the way. Remember: details around interim
"failed" attempts are as important as the final solution.

* All code used in your solution. By "All" this means everything necessary to recreate your scenario and solution. This
includes any means you used to measure and analyze your results.

* Timing of the overall activity is important. For example: how long did it take for you to create the file set and
analyze the results? While speed of operation is not the primary goal for this exercise (efficacy is), timing
information is always informative

* Extra credit is given for striking a clear balance between robustness and simplicity.


Support Files:

* This exercise does not require any initial data sets.


Assumptions:

* Disk space should not be an issue during this experiment.
* The solution both can (and should) assume that the target file system (NTFS/ext4/etc.) is of sufficient size to house
the files/data in a contiguous set and single namespace.
