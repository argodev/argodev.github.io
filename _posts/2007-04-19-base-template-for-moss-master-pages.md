---
layout: post
category: technology
title: 'Base Template for MOSS Master Pages'
date: 2007-04-19 00:00
tags:
- sharepoint
- moss
redirect_from:
- /blog/2007/4/19/base-template-for-moss-master-pages.html
---
I'm posting this more for my own benefit (able to find it later) than anything, but while working on a master page customization for a client I stumbled across a posting on MSDN on how to create a minimal master page (http://msdn2.microsoft.com/en-us/library/aa660698.aspx).

I ran into a few issues simply using the code as presented...

1. SPD didn't like the ASP.NET style comments... that really threw it for a loop and it kept removing items from the code with no warning... changing those comments to HTML-style fixed things
2. The first item in the community content section didn't seem to apply... things looked fine.
3. The second item in the community content section was correct.
4. I also had to add a content placeholder stub for "PlaceHolderTitleRightMargin" in order for everything to work properly for me
