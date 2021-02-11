---
category: technology
title: 'The Danger with using a framework…'
date: 2010-02-26 00:00
tags:
- miscellaneous
- c#
redirect_from:
- /blog/2010/2/26/the-danger-with-using-a-framework.html
---
The danger with using a framework is that sometimes it does things that you aren’t aware of that can send you in circles for  quite some time before you figure them out.

I’ve been working on some tests of some “creative” ways to get data in and out of cloud platforms at rates above the norm and I’ve written a test harness that I’ve been using that will grab a bunch of files, one at a time, and record the file size, duration, etc. for the transfer. I’ve been doing this in a single-threaded fashion for quite some time with reasonable success. The problem began when I attempted to use to run a test that did multi-threaded downloads (multiple threads each grabbing a portion of the file).

NOTE/Crazy Quirk: I don’t yet know why this is the case, but the problem I’m preparing to explain did *not* appear while I had Fiddler running… only when it was *not* running. I’m guessing that this is due to some “magic” that Fiddler does to the HTTP/networking stack..

The behavior I was seeing, was that after two threads would execute, all subsequent threads would fail or timeout. Obviously, when one is doing a significant amount of data movement, this is sub-ideal. The culprit turned out to be the ServicePointManager’s DefaultConnectionLimit. By default, this is configured to 2 which means you can, at most, have 2 open connections to the same TLD at the same time. When I was doing this in serial, there was no problem as the connections were managed/re-used on the main (only) thread.  When doing a number of operations to the same URL (TLD) from multiple threads (especially when you are setting up/tearing them down quickly), it appears that the ServicePointManager is unable to re-use them (not surprising) but neither is it able to determine that the thread is now gone as should be the connection count. (yes, I was behaving and closing my connections).

The solution I came up with was to first shorten the time to live for idle threads, next to monitor the number of threads currently “consumed” and to increase the limit based on how many I needed for the current operations, all while ensuring an upper bound and stand-off mechanism should things get too far out of bounds.


```c#
// ensure that we don't have lingering connections that will hamper our
// ability to continue...
// Start by getting the ServicePoint for our current Url
ServicePoint servicePoint =
    ServicePointManager.FindServicePoint(new Uri(url));

// see how many connections currently exist...
int existingConnections = servicePoint.CurrentConnections;

// if we are above our upper bound, wait a bit to let things settle down...
while (existingConnections >= 64)
{
    Console.WriteLine("Connection count too high. sleeping for a bit.");
    Thread.Sleep(1000);
}

// ensure that we have enough room to do what we need
if ((existingConnections + options.ConcurrentThreads + 1) >
    servicePoint.ConnectionLimit)
{
    servicePoint.ConnectionLimit = existingConnections +
        options.ConcurrentThreads + 1;
}

// only give them a few seconds (5) to time out...
ServicePointManager.MaxServicePointIdleTime = 5000;

Console.WriteLine("Pre-Existing Connections: {0}", existingConnections);
Console.WriteLine("Connection Limit: {0}", servicePoint.ConnectionLimit);
```

Hopefully, this will be helpful for someone else hitting the same issue.
