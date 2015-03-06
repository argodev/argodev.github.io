I'm continuing to work on a .NET version of the DAC (Delegated Administration Console) - essentially a UI front-end for 
the Microsoft provisioning System and specifically Hosted Exchange 2003.1... I've been learning a number of things and 
experimenting with some very interesting (at least to me) technologies.  I thought I'd share a little here and maybe 
post some more detail on each of these items over the next couple of weeks...

###Themes/Skins
One thing I'm very interested in for this project is the ability to change the look/feel of the web site based on the 
user who signed in.  This should be controlled by the parent reseller for the user allowing the resellers to 
“White label“ the hosted service.  Whidbey has some very interesting support along this line, but the requirement for 
this project is to use ASP.NET 1.1, so I cannot utilize those features.  I found an interesting article written by Dino 
Espositio in the June ed. of MSDN magazine.  this is the second of two articles on the topic... the article in the May 
ed. was interesting, but not really useable, esp. compared to the enhancements made and presented in the June article.  
This article really stretched my outlook with respect to using asp.net and how the underlying framework functions.  In 
my opinion, this is a good coding exercise for any advanced asp.net dev to help them think “outside the box“ on their 
projects.

###Web Layout (a.k.a. Master Pages)
This topic seems to garner a great deal of interest and comments throughout the ASP.NET development community.  We all 
know that Whidbey is coming with all sorts of wonderful things for this topic, but that is little help to those of us 
who have customer deliverables in the next 12 months (or however long until Whidbey actually ships).  There are a ton 
of different ways to accomplish this, all with their pros and cons.  The most interesting option I've seen is provided 
by Paul Wilson ([http://authors.aspalliance.com/PaulWilson/Articles/?id=14]).  This approach is an extended/improved 
version of a sample provided to the asp.net web site by Rob Howard (MS) and is similar in some ways to what we have 
seen in Whidbey.  It may not suit your needs, but if this topic is something you are interested in, this approach is 
definitely worth the review.  I felt that the article text didn't do the best job of explaining what was actually 
happening (may have just been me) but once I converted the sample code to C# (my way of studying the code) and was able 
to get it working in my own site, it was very clear and easy to use.

###Role-Based Controls
One of the most interesting (in my opinion) things that we accomplished in the ASP-based version of the DAC was to 
selectively hide/show/modify the UI and controls based on the assigned role of the currently logged on user.  In the 
ASP version of the DAC, this is handed via a combination of xml definition files that contain the control definitions 
and “acl” definitions and an ASP library called UIFramework.asp.  For this project i was looking for a more elegant way 
to store this information and a way to locate the role information as close to the control in question as possible.  My 
current approach is to create a library of web controls that inherit directly from the corresponding “official” control 
yet implement a set of properties extended for the UI options.  I'm overriding the OnPreRender method and planning on 
controlling the state of the control (i.e. visible = t/f and enabled = t/f) at this level.  I've not completely fleshed 
this out nor tested it in conjunction with the other items listed above, so we will see how well it does/doesn't work... 
more on this topic later.
