---
layout: post
category: technology
title: 'Azure Blob Storage Blob IDs and “+”'
date: 2009-07-30 21:35
---
I’ve been kicking the tires on Azure’s blob storage and am working on uploading a 1.2GB+ NetCDF file. I stumbled across
a couple of [samples online](http://azuredba.com/Blog/tabid/621/EntryId/183/A-REST-ful-Look-at-Azure-Blob-Storage-continued.aspx)
that were very helpful in avoiding the de facto client library that ships with the SDK however I found myself bit by
something (likely due to my error somehow) that I thought I’d pass along.

When processing a larger file, my upload process would always fail at block #248. At first, I assumed it was a network
transience issue and simply re-ran the upload, however, after having it fail on the exact same block 3 times, I decided
that it wasn’t the network. In digging a bit into things, I found that the problem had to do with the encoding of the
block IDs. The offending piece of code is here:

    for (int i = 0; i < blocksCount; i++)
    {
        blockIds[i] = Convert.ToBase64String(BitConverter.GetBytes(i));

Where `i` is an integer representing the index of the current block within the file and `blockIds` is an array of IDs
used to build the block ID list as part of a `putBlockList` operation.

The Azure SDK would indicate that this code snippet is perfectly valid… block IDs need to be a base 64-encoded string
uniquely identifying the block within the blob. Further, each ID (within a blob) must be of the same length prior to
encoding (same number of bytes). In this scenario, `BitConverter.GetBytes` returns a 4-byte array of values for all
numbers within the range (in my case, 0 – 314). The following is an example of the resulting string for some numbers:

* `246: 9gAAAA==`
* `247: 9wAAAA==`
* `248: +AAAAA==`

There continues about 4 that begin with a ‘+’ sign, and a similar number that begin with ‘\’. Every other index in my
collection began with a normal alpha character. After doing some poking around I found some indications that others
were having similar problems and went down the path of encoding the line differently (i.e.
`HttpServerUtility.UrlTokenEncode`, etc) to no avail. What I ended up with is simply prefixing my values with a
standard “safe” string (“BlockId”)

    for (int i = 0; i < blocksCount; i++)
    {
        blockIds[i] = Convert.ToBase64String(
            ASCIIEncoding.ASCII.GetBytes(
            string.Format("BlockId{0}", i.ToString("000"))));

This yielded a blockId that was unique, consistent length (notice the formatting of the indexer in the `ToString()`
method), and “safe” in that it always began with a URL-safe character.

I’m certain that there is likely a better way to solve this problem, but this did the trick for me and maybe it will
be helpful to someone else.