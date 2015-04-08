---
layout: post
category: technology
title: 'Maximizing Throughput in Windows Azure – Part 1'
date: 2010-09-13 21:35
---

I’m working on a writing a paper dealing with the issue of maximizing data throughput when interacting with the Windows
Azure compute cloud and am drafting some of that work as a couple of blog posts to help me work through my thoughts.
I’m still working through some test scenarios and will have more to post later, but I wanted to get this out while it
was still fresh.

I’ve [posted before](/technology/2010/external-file-upload-optimizations-for-windows-azure), that utilizing parallelized
file file transfers is a great way to increase your overall throughput when externally interacting with Windows Azure,
and the unsaid but possibly inferred thought was that it worked well for internal-to-Azure data movements as well. At
the time I wrote the initial post I had done some testing of this scenario and had mixed results. A couple of recent
papers I’ve read got me thinking about the topic again and so I started testing further with a slightly different
approach and a different take on the variables.

__Summary__: Within the context of the Azure datacenter (intra-datacenter transfers), sub-file parallelization is not
always as beneficial as it is outside the datacenter (local to azure or azure to local). Further, the size of the VM
host has a significant impact on the realized throughput.

__Detail__: The key point I pulled from a paper I was reading (I’m sorry, I don’t have the reference at this time) was
that another researcher had been doing tests in the Amazon cloud and indicated they were seeing significant deltas in
throughput based on the Instance size/type they selected. Neither Microsoft nor Amazon list bandwidth as a variable
associated with instance types (with the possible exception of the
[Amazon Cluster Compute Instance](http://aws.typepad.com/aws/2010/07/the-new-amazon-ec2-instance-type-the-cluster-compute-instance.html)
which boasts a 10Gbps network) but it stands to reason that given a physical host of a fixed size, an increase in the
number of virtual hosts on that box (smaller instances) will result in a decrease in available throughput per virtual
host. The inverse (scenarios with larger instances)also follows. This got me to thinking about Azure and whether or not
the same would hold true, and, if so, how that would impact our recommended approach of splitting your files,
transferring them in parallel, and then reassembling them on the other side.

__Approach__: Rather than doing a parameter sweep on a number of file sizes, I selected a specific file size (500 MB)
of randomly generated data and executed my tests with that. For each parameter set, I ran executed 3 runs of 50
transfers each (150 total per parameter set). I also tore down and re-published my platform between each run to
increase my chances of being provisioned to different hardware nodes within the Azure datacenter and – theoretically, a
different contention ratio with other instances on the same physical host. Also, I performed a run for all parameter
sets before starting subsequent runs to decrease the likelihood that one parameter set would be inappropriately
benefited (or harmed) by the time of day in which it was executed. In each test, a single worker role instance was run
targeting a single storage account. There were no other applications or activities targeting that storage account
during the tests runs. All of these tests were performed in the Windows Azure US North Central region between the dates
of August 27, 2010 and September 2, 2010

__Results__: The first sweep was aimed at identifying the impact of VM size on transfer rate using the standard
MS-provided storage client library (no modifications). What we found, was that, for the most part, there was a clear
relationship between the VM size and the realized throughput.

<img alt='s1chart2' src='/assets/images/s1chart2.png' class='blogimage img-responsive'>

<img alt='s1chart4' src='/assets/images/s1chart4.png' class='blogimage img-responsive'>

The second sweep had a similar objective as the first, with the only change being that rather than using the
standard/single-threaded API calls, we used the parallelized version that we developed for our external-to-Azure tests.
The results were similar to the above in that the node size showed (mostly) a consistent impact on the realized
throughput (_keep reading past the charts if you review the following and think I’m out of my mind_).

<img alt='s1chart1' src='/assets/images/s1chart1.png' class='blogimage img-responsive'>

<img alt='s1chart3' src='/assets/images/s1chart3.png' class='blogimage img-responsive'>

If you are still with me, you are probably wondering why the numbers for the Parallel Upload by Node Size chart look so
off from the assumed behavior… The fact of the matter is that similarly to the small node standard download tests, the
third run for the small node parallel upload tests experienced a radically different performance (>75% better) than the
prior two runs. This was so jolting to the numbers that I actually prepared another chart showing only the first two
runs of this test to illustrate the difference that the last run made in the average results:

<img alt='s1chart8' src='/assets/images/s1chart8.png' class='blogimage img-responsive'>

As you can tell from the above, these results are much closer to what you might expect (based on the values from the
other tests above). The key take-away at this point, and the reason I am belaboring this aberration, in an environment
where you are not in complete control, the performance you obtain from shared services (networks, storage clusters,
etc) may vary widely in actual use.

The real question of interest, was to compare the two approaches (standard library vs. parallelized) so one could
select the best one for a given scenario. The first chart showed exactly what I expected – the parallelized version was
significantly better than the standard approach for all node sizes although the benefit waned as the node size
increased.

<img alt='s1chart5' src='/assets/images/s1chart5.png' class='blogimage img-responsive'>

The second chart initially caught me off guard as it illustrated that the work being done to block/download/reassemble
in parallel was __*far*__ less efficient than simply downloading the data.

<img alt='s1chart6' src='/assets/images/s1chart6.png' class='blogimage img-responsive'>

My initial thoughts were that I was simply using an inefficient mechanism for reassembling the file but that the
parallelized transfer was still likely faster than the stock approach but some additional instrumentation invalidated
that thought. For the parallelized version, roughly 50% of the total time per file was spent in reassembling it,
however even considering just the 50% spent in network transfer, it was roughly 50% longer than the stock approach (I’ll
dig into that a bit more in later posts).

Therefore, from the data and tests we’ve run so far, using a blocked or chunked approach and parallelized transfers
works well for external-to-Azure uploads and downloads as well as uploads (compute to blob storage) for
internal-to-Azure movements. Internal-to-Azure downloads (blob storage to compute targets) should be performed using the
standard/non-parallelized approach.

This last chart is designed to give an idea of the realized throughput by node for both upload and downloads using the
“optimal” approach as determined via the tests detailed above.

<img alt='s1chart7' src='/assets/images/s1chart7.png' class='blogimage img-responsive'>

As you can imagine, the results listed here triggered a number of other questions and tests. Some of these will be
addressed in the next post on this topic which should be available soon.
