---
category: technology
title: 'Maximizing Throughput in Windows Azure - Part 2'
date: 2010-09-20 00:00
tags:
- cloud computing
- azure
- storage
redirect_from:
- /blog/2010/9/20/maximizing-throughput-in-windows-azure-part-2.html
---

>NOTE: Updated 9/23/2010. See bottom of this post for an explanation of the changes]

This is the second in a series of posts I’m writing while working on a writing a paper dealing with the issue of maximizing data throughput when interacting with the Windows Azure compute cloud. You can read the
[first part here]({{ site.url }}{{ site.baseurl }}/technology/2010/09/13/maximizing-throughput-in-windows-azure-part-1/). I’m still running some different test scenarios so I expect there to be another post or two in the series.

## Summary

Our tests confirmed that while within the context of the Azure datacenter (intra-datacenter transfers), sub-file parallelization for downloads (Azure blob storage to Azure Compute) is not recommended (overhead is too high), whole-file-level parallelization (parallelizing the transfer of multiple complete files) does provide a significant increase in overall throughput when compared to transferring the same number of files sequentially. Also, consistent with our prior tests, the size of the VM has a direct correlation to the realized throughput.

## Detail

During the testing described in [Part 1]({{ site.url }}{{ site.baseurl }}/technology/2010/09/13/maximizing-throughput-in-windows-azure-part-1/), we saw that the attempts to parallelize at the sub-file level for downloads within the Azure datacenter was significantly more expensive (on average 76.8% lower throughput) as compared to direct transfers. As such sub-file parallelization is not recommended for downloads within the Azure datacenter.

As I considered these results and thought through where the bottleneck might be, I went back through and re-instrumented the test so I could get a time snap in midst of the parallel download routine at the spot after the file blocks have been downloaded and prior to reassembling the file. What I found was that roughly 50% of the time of an individual operation was consumed in network transfer while the other half was spent assembling the individual blocks into a single file. While this gave me some ideas for further optimization, the 50% time for transfer was still significantly longer than the entire non-blocked operation (by almost 50%). As such, it seemed beneficial to take a completely different approach to improving the transfer speed.

What we came up with was to parallelize at the whole file level rather than at the sub-file level. This effectively eliminated half of the prior parallelization effort cost (no reassembly) and wouldn’t involve the overhead of querying the storage platform for the size, and then issuing a collection of range-gets.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/s2chart1.png"><img src="{{ site.url }}{{ site.baseurl }}/images/s2chart1.png" alt="s2chart1"></a>
</figure>

As you can see from the chart above, even in the worse case, there is a significant improvement in the overall throughput when files are transferred simultaneously rather than sequentially. While the individual-file transfer rate dropped (average 40.1% worse), the overall transfer rate averaged 86.21% better.

Consistent with our prior results, instance size plays a role in the bandwidth. Our tests showed an average improvement in realized throughput per step increase in instance size of 14.46% (please see following note)

>__Note__: A review of the chart hints that the small instance size takes a significant hit in the area of total network throughput and, while this accurately reflects the data collected, the third run took abnormally longer than the first two and pulled down the total results. This can be explained by a number of different factors (e.g. heavy contention on the host for network resources). I ran the test for that scenario a 4th time to satisfy my curiosity as to whether or not the third run was reflective of a larger trend and the results of the fourth run were much closer to that of the first two. So much so that if I were to substitute the fourth run results for the third run results, the overall improvement due to parallelism raises to 89.46% and  the average improvement in throughput by step increase in node size goes to 10.75%. It is my belief that if I were to have run these tests/scenarios more, the outliers would have reduced and the results would be closer to those ignoring the 3rd run rather than including it.

## Approach

Rather than doing a parameter sweep on a number of file sizes, I selected a specific file size (500 MB) of randomly generated data and executed my tests with that. For each parameter set, I ran executed 3 runs of 50 transfers each (150 total per parameter set). While the transfer time of each file was tracked, the total time transfer time (for all 50 files in the run) was the primary value being collected and represented in the charts above. It should be noted that this total time includes a little bit of time per file for tracing data so, in a scenario wherein that tracing activity was not present, the numbers above might be slightly better. I also tore down and re-published my platform between each run to increase my chances of being provisioned to different hardware nodes within the Azure datacenter and – theoretically, a different contention ratio with other instances on the same physical host. Also, I performed a run for all parameter sets before starting subsequent runs to decrease the likelihood that one parameter set would be inappropriately benefited (or harmed) by the time of day in which it was executed. In each test, a single worker role instance was run targeting a single storage account. There were no other applications or activities targeting that storage account during the tests runs. All of these tests were performed in the Windows Azure US North Central region between the dates of August 27, 2010 and September 2, 2010

> NOTE: This post was updated on 9/23/2010. The changes are both substantial and not at the same time. While working on the other posts in the series, I became concerned that there were too many calculations being performed ad-hoc in Excel to get from the raw data to the charts and conclusions described here. A key goal of mine is for someone who questions my results to be able to re-run them and analyze my analysis of the data. Therefore I stepped back and generated the charts using code that shows each calculation and query. The links to the code are posted above as are links to the raw data. The charts are identical to what were here originally with the exception of some formatting changes due to the differences in generation engines. The charts are also higher-resolution and clicking on them will open the full-size version of the chart.

<small>Research sponsored by the Laboratory Directed Research and Development Program of Oak Ridge National Laboratory, managed by UT-Battelle, LLC, for the U. S. Department of Energy.</small>
