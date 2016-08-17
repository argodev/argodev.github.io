---
layout: post
category: technology
title: 'Time to do some digging…'
date: 2009-12-21 00:00
tags:
- cloud computing
- azure
- outage
- storage
redirect_from:
- /blog/2009/12/21/time-to-do-some-digging.html
---
I’ve been getting my test harness and reporting tools setup for some performance 
baselining that I’m doing relative to cloud computing providers and when I left 
the office on Friday I set off a test that was uploading a collection of binary 
files (NetCDF files if you care) to an Azure container. I was doing nothing 
fancy... looping through a directory, for each file found, upload to the 
container using the defaults for BlobBlock and then record the duration 
(start/finish) for that file and the file size. The source directory contained 
144 files representing roughly 58 GB of data. 32 of the files were roughly 
1.5 GB each and the remainder were about 92.5 MB.

I came in this morning expecting to find the script long finished with some 
numbers to start looking at. Instead, what I found is that, after uploading 
some 70 files (almost 15 GB), every subsequent upload attempt failed with a 
timeout error – stating that the operation couldn’t be completed in the default 
90-second time window. I started doing some digging into what was happening and 
so far have uncovered the following:

* By default, the Storage Client that ships with the November CTP breaks your 
file up into 4 MB blocks (assuming you are using BlobBlock – which you should if 
your file is over the 64 MB limit.

* The client then manages 4 concurrent threads uploading the data. as each 
thread completes, another is started – keeping four active most the entire time.

* At some point Saturday afternoon (just after 12 noon UTC), the client could no 
longer successfully upload a 4 MB file (block) in the 90 second window, and all 
subsequent attempts failed.

* I initially assumed that my computer had simply tripped up or that a local 
networking event caused the problem so I restarted the tool – only to find every 
request continuing to fail.

* I then began to wonder if the problem was the new storage client library (not 
sure why) so I pulled out a tool to manage  Azure storage – 
[Cloud Storage Studio](http://www.cerebrata.com/Products/CloudStorageStudio/Default.aspx) 
and noticed that I was able to successfully upload a file. I remembered that 
CSS (by default) splits the file into fairly small blocks, so I cracked open 
[Fiddler](http://www.fiddler2.com/fiddler2/) and began monitoring what was going 
on. I learned that it was using 256 KB blocks (this is configurable via settings in the app).

* I then adjusted my upload script to set the `ServiceClient.WriteBlockSizeInBytes` 
property (`ServiceClient` is a property of the `CloudBlockBlob` object) to 256k 
and re-ran the script. This time, I had no troubles at all (other than a 
painfully slow experience).

* So, I can upload data (not a service outage) but while 256K blocks work, 
the 4 MB blocks that worked on Friday no longer work – I’m assuming that there’s 
a networking issue on my end, or something in the Azure platform. To provide 
more clarity, I adjusted the tool again, this time using a `WriteBlockSizeInBytes` 
value of 1MB and re-ran the tool – again, seeing successful uploads.
 
While this last step was running, I thought it might be good to go back and do 
some crunching on the data I had so far. The following chart represents the 
uploads rate from the files that successfully were uploaded on Friday/Saturday 
followed by the a chart showing the probability density. The mean rate was 
2.74 mbits/sec with a standard deviation of 0.1968. It is interesting to note 
that there was no upward drift at the end of the collection of successful runs, 
indicating that more than likely, the “fault” was likely caused by something 
specific rather than being the result of a gradual shift or failure based on 
usage (imagine a scenario wherein as more data is populated in a container, 
indexes slow down, causing upload speeds to trail off).

<img alt='Upload Rate' src='/images/uploadrate.png' class='blogimage img-responsive'>
Upload Speeds [click image for full size]

<img alt='Upload Rate Standard Deviation' src='/images/uploadratestddev.png' class='blogimage img-responsive'>
Probability Density [click image for full size]

 

I then ran similar reports against the data I from this morning’s runs. I’m 
still in the process of generating a full report on the data, but a 
representative sample shows the following: The mean upload rate was 0.15 
mbits/sec with a standard deviation rate of 0.0375. _This is over __17x slower__ than Friday_. 
This data points represented below are for three batches – the first batch used 
a `WriteBlockSizeInBytes` of 256K, the second used 1MB, and the third used 2MB 
(10 points per size). The file upload did not succeed with the 2MB size – only 
finished about 1/4th of the full file.

 
<img alt='Upload Speeds' src='/images/uploadspeeds.png' class='blogimage img-responsive'>
Upload Speeds [click image for full size]

<img alt='Upload Rate Standard Deviation' src='/images/uploadratestddev1.png' class='blogimage img-responsive'>
Probability Density [click image for full size]

I’ve seen a few comments from others today that indicate the slow down may be 
widespread – My next course of action is to attempt to run the tests from a few 
different locations to hopefully eliminate my local network as the problem set 
and have more data with which to address the issue.
