---
layout: post
category: technology
title: 'Welcome to the blog'
date: 2004-01-28 00:00
tags:
- miscellaneous
- personal
redirect_from:
- /blog/2004/1/28/welcome-to-the-blog.html
---
People use their blogs for all sorts of different things, I intend for mine to be a sort of “diary” of my work as I learn/increase my learning of a certain few Microsoft Technologies: MPF, BTS, C#, .NET, Whidbey, and Yukon.

As part of my work on learning Whidbey and how it interact with IIS6 and Window Server 2003, I have begun building a little user self-management portal integrating Whidbey and MPF.  I have successfully integrated the .NET client wrapper with my Whidbey project (adding the reference was a bit different with a web site than it had been in the past) and am properly passing credentials and security contexts all the way through from the logged in user, through to AD and then back again.

I'm currently working on building an “AUO”-like object.  For those of you old enough to remember programming against Site Server 3.0, the AUO (Active User object) was one of the coolest features - it was an object that represented the currently signed-on user and all of its properties that you could simply call from any of your pages.  So, if you wanted to read the user's first name you could call `auo.firstname` and have it.  Whidbey has something that looks similar in the `ADMembershipProvider`, but the documentation on this item is sketchy at this point.

I'm also re-evaluating the MPF procedure` GetCallerUIRoles`.  Essentially all this does is a test to see if  a user is a member of a particular group or set of groups within AD.  It does this by trying to bind to each of a collection of groups and attempting to read the DACL on each one.  The security has been set such that only the SELF role has permissions to perform this action.  I'm thinking that, while this works, it would be much more efficient to do a simple read using the `user.IsInRole()` in the application code... still thinking through that.

I'll post more as I make more progress.
