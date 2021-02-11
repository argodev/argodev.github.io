---
category: technology
title: 'VisualStudio.Net.2005.Beta2(firstExperience) == Really.Good;'
date: 2005-04-21 00:00
tags:
- general development
- tools
- vs2005
redirect_from:
- /blog/2005/4/21/visualstudionet2005beta2firstexperience-reallygood.html
---
Wow… early this morning was the first time that I was really able to spend some time with the new Visual Studio 2005 beta… and let me join the majority of the blogsphere in saying that I’m quite impressed.  My task today was a simple one… that of converting a primarily content-focused website that I had build using Dreamweaver MX to ASP.NET 2.0.  The following are some general impressions…

1. Vault and the beta work great together…. We are actually running an older version of Vault (2.06) yet it still connected up and worked like a champ… in fact, I was amazed at how fast the source control operations (checkin/out) were compared to RTM version of VS 2003 and the same Vault environment… a very nice start…

2. Project-less websites are great … no more adding files to the solution/project… VS simply “knew” about all of the files in the directories I was working on… it is very nice.

3. Master pages “just work”… As someone who has used the templating feature in Dreamweaver, and has also built an ASP.NET master-pages “engine” (capitalizing heavily on the work of Rob Howard and team, supplemented by Paul Wilson) I wasn’t “amazed” by the master pages feature… I just wanted it to work better/faster than my current tools and hopefully have a better implementation.  I was not disappointed… the Master Pages support was easy, and quick to utilize…. now if only they could get nested master pages to work in the designer…

4. XHTML compliance… finally… Some people probably don’t care so much about standards compliance, but I’ve been working pretty hard lately on some of these sites to make them XHTML compliant… this site in particular had been compliant until I added some ASP.NET controls (text boxes, buttons, validators, etc.).  I moved things over this morning, fired up the page, ran the W3C validator (thanks to the Checky extension for FireFox) and it validated (XHTML Strict) on the first run… very impressive

5. System.Web.Mail is deprecated… most of you all probably knew this already… and yes, I probably have had my head in the sand, but I was surprised when the compiler griped at me this morning about my form that sends mail based on user input… I took some time and without too much work was able to get the form processing code using the System.Net.Mail namespace which seems to be the new “right” way to do it… works like a champ.

I’m very excited… don’t have time to talk about the built-in webserver, or direct FTP support… which is great….  I’ll post more later.
