---
category: technology
title: 'External File Upload Optimizations for Windows Azure'
date: 2010-04-26 00:00
tags:
- cloud
- theory
- aws
- azure
redirect_from:
- /blog/2010/4/26/external-file-upload-optimizations-for-windows-azure.html
---

I’m wrapping up a bit of the work we’ve been doing on data movement optimizations for cloud computing and the latest set of data yielded some interesting points I thought I’d share. The work done here is not really rocket science but may, in some ways, be slightly counter-intuitive and therefore seemed worthy of posting.

## Summary

For those who don’t like to read detailed posts or don’t have time, the synopsis is that if you are uploading data to Azure, block your data (even down to 1MB) and upload in parallel. Set your block size based on your source file size, but if you must choose a fixed value, use 1MB. Following the above will result in significant performance gains… upwards of 10x-24x and a reduction in overall file transfer time of *upwards of 90% (eg, uploading a 1GB file averaged 46.37 minutes prior to optimizations and averaged 1.86 minutes afterwards)*.

## Detail

For those of you who want more detail, or think that the claims at the end of the preceding paragraph are over-reaching, what follows is information and code supporting these claims. *As the title would indicate, these tests were run from our research facility pointing to the Azure cloud (specifically US North Central as it is physically closest to us) and do not represent intra-cloud results… we have performed intra-cloud tests and the overall results are similar in notion but the data rates are significantly different as well as the tipping points for the various block sizes… this will be detailed separately)*.

We started by building a very simple console application that would loop through a directory and upload each file to Azure storage. This application used the shipping storage client library from the 1.1 version of the azure tools. The only real variation from the client library is that we added code to collect and record the duration (in ms) and size (in bytes) for each file transferred. [The code is available here](http://code.google.com/p/scientificcloudcomputing/source/browse/#svn/trunk/AzureTesting/AzureTesting).

We then created a directory that had a collection of files for the following sizes: 2KB, 32KB, 64KB, 128KB, 512KB, 1MB, 5MB, 10MB, 25MB, 50MB, 100MB, 250MB, 500MB, 750MB, and 1GB (50 files for each size listed). These files contained randomly-generated binary data and do not benefit from compression (a separate discussion topic). [Our file generation tool is available here](https://code.google.com/p/scientificcloudcomputing/source/browse/#svn/trunk/Utilities/RandomFileGenerator).

The baseline was established by running the application described above against the directory containing all of the data files. This application uploads the files in a random order so as to avoid transferring all of the files of a given size sequentially and thereby spreading the affects of periodic Internet delays across the collection of results. We then ran some scripts to split the resulting data and generate some reports. The raw data collected for our non-optimized tests is available via the links in the Related Resources section at the bottom of this post.

For each file size, we calculated the average upload time (and standard deviation) and the average transfer rate (and standard deviation). As you likely are aware, transferring data across the Internet is susceptible to many transient delays which can cause anomalies in the resulting data. It is for this reason that we randomized the order of source file processing as well as executed the tests 50x for each file size. We expect that these steps will yield a sufficiently balanced set of results.

Once the baseline was collected and analyzed, we updated the test harness application with some methods to split the source file into user-defined block sizes and then to upload those blocks in parallel (using the `PutBlock()` method of Azure storage). The parallelization was handled by simply relying on the Parallel Extensions to .NET to provide a `Parallel.For` loop (see linked source for specific implementation details in `Program.cs`, line 173 and following… less than 100 lines total). Once all of the blocks were uploaded, we called `PutBlockList()` to assemble/commit the file in Azure storage. For each block transferred, the MD5 was calculated and sent ensuring that the bits that arrived matched was was intended. The timer for the blocked/parallelized transfer method wraps the entire process (source file splitting, block transfer, MD5 validation, file committal). A diagram of the process is as follows:

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/ParallelAzureUploadDirect.png"><img src="{{ site.url }}{{ site.baseurl }}/images/ParallelAzureUploadDirect.png" alt="ParallelAzureUploadDirect"></a>
</figure>

We then tested the affects of blocking & parallelizing the transfers by running the updated application against the same source set and did a parameter sweep on the block size including 256KB, 512KB, 1MB, 2MB, and 4MB (our assumption was that anything lower than 256KB wasn’t worth the trouble and 4MB is the maximum size of a block supported by Azure). The raw data for the parallel tests is available via the links in the Related Resources section at the bottom of this post.

This data was processed and then compared against the single-threaded / non-optimized transfer numbers and the results were encouraging. [The Excel version of the results is available here](https://docs.google.com/a/sciencecloud.us/leaf?id=0B3DNk-MaLIN-MmRjYTkwY2EtMjk2Zi00NTk0LWI5ZTgtZGMzOWE5ZmIwOTc2&hl=en).

Two semi-obvious points need to be made prior to reviewing the data. The first is that if the block size is larger than the source file size you will end up with a “negative optimization” due to the overhead of attempting to block and parallelize. The second is that as the files get smaller, the clock-time cost of blocking and parallelizing (overhead) is more apparent and can tend towards negative optimizations. For this reason (and is supported in the raw data provided in the linked worksheet) the charts and dialog below ignore source file sizes less than 1MB.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/RateImprovement.png"><img src="{{ site.url }}{{ site.baseurl }}/images/RateImprovement.png" alt="RateImprovement"></a>
</figure>

The chart above illustrates some interesting points about the results:

- When the block size is smaller than the source file, performance increases but as the block size approaches and then passes the source file size, you see decreasing benefit to the point of negative gains (see the values for the 1MB file size)
- For some of the moderately-sized source files, small blocks (256KB) are best
- As the size of the source file gets larger (see values for 50MB and up), the smallest block size is not the most efficient (presumably due, at least in part, to the increased number of blocks, increased number of individual transfer requests, and reassembly/committal costs).
- Once you pass the 250MB source file size, the difference in rate for 1MB to 4MB blocks is more-or-less constant
- The 1MB block size gives the best average improvement (~16x) but the optimal approach would be to vary the block size based on the size of the source file.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/RateImprovement2.png"><img src="{{ site.url }}{{ site.baseurl }}/images/RateImprovement2.png" alt="RateImprovement2"></a>
</figure>

The above is another view of the same data as the prior chart just with the axis changed (x-axis represents file size and plotted data shows improvement by block size). It again highlights the fact that the 1MB block size is probably the best overall size but highlights the benefits of some of the other block sizes at different source file sizes.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/DurationReduction.png"><img src="{{ site.url }}{{ site.baseurl }}/images/DurationReduction.png" alt="DurationReduction"></a>
</figure>

This last chart shows the change in total duration of the file uploads based on different block sizes for the source file sizes. Nothing really new here other than this view of the data highlights the negative affects of poorly choosing a block size for smaller files.

## Summary

What we have found so far is that blocking your file uploads and uploading them in parallel results in significant performance improvements. Further, utilizing extension methods and the Task Parallel Library (.NET 4.0) make short work of altering the shipping client library to provide this functionality while minimizing the amount of change to existing applications that might be using the client library for other interactions.

## Related Resources

- [Source code for upload test application](http://code.google.com/p/scientificcloudcomputing/source/browse/#svn/trunk/AzureTesting/AzureTesting)
- [Source code for random file generator](https://code.google.com/p/scientificcloudcomputing/source/browse/#svn/trunk/Utilities/RandomFileGenerator)
- [Excel worksheet showing summarizations and comparisons](https://docs.google.com/a/sciencecloud.us/leaf?id=0B3DNk-MaLIN-MmRjYTkwY2EtMjk2Zi00NTk0LWI5ZTgtZGMzOWE5ZmIwOTc2&hl=en)
