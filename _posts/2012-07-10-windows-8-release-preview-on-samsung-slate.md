---
layout: post
category: technology
title: 'Windows 8 Release Preview on Samsung Slate'
date: 2012-07-10 00:00
tags:
- Miscellaneous
- windows8
redirect_from:
- /blog/2012/7/11/windows-8-release-preview-on-samsung-slate.html
---
I've been playing with Windows 8 on a Samsung 700T1A slate for a number of months and was quite excited with the Release
Preview was announced and attempted to install it straight away. Unfortunately, I was unable to get it installed right
away and set it aside for awhile, trying occasionally, failing, and setting it aside.

The problem I was having, was that the slate wouldn't boot to the Windows 8 media - DVD, USB, no matter what I burned it
to, it wouldn't work. I even verified that the media was valid by using it to install on other machines.

Tonight, I finally got it working and the problem was both so odd, and simple, that I thought I'd post it here to maybe
help someone else who comes along searching for the same problem.

It seems that the slate, when shipped, has a bios setting that has "Support for Legacy USB" devices enabled. However,
as soon as the system is updated with a purchase date, it automatically flips this switch (presumably for faster boots).
Unfortunately, this also causes it to not check for bootable USB devices during POST (cf.
<http://skp.samsungcsportal.com/integrated/popup/FaqDetailPopup3.jsp?cdsite=hk_en&seq=431318>)

The post that tipped me off was this:
<http://skp.samsungcsportal.com/integrated/popup/FaqDetailPopup3.jsp?cdsite=hk_en&seq=431320>

<img alt='Bios' src='/images/bios.jpg' class='blogimage img-responsive'>
<small>(image courtesy of Samsung)</small>

However, the bios on my slate didn't look like this - there is no Fast BIOS Mode menu item. However, there is a menu
item that says "Support Legacy USB Devices". Based on this article and the previous one, I took a guess that changing
this would fix it and, magically, everything worked just as you would have expected.
