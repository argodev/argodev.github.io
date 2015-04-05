I've had the privilege of working with an organization for almost two years now doing alot of SharePoint development.
There's a team of approximately 75 developers that cover the gamut of skill sets and experiences, most of whom are
working, to some degree, with C# and SharePoint development. One of the things that has come up repeatedly, is "how do
I get started"? or "what project template should I be using"? These are good questions without a completely clear
answer. This post (and hopefully some following) are intended to discuss what we are using, how it evolves, what
options we discarded, and why. I spent last Friday teaching a class attempting to bring our team up to speed as to how
to structure their SharePoint solutions/projects in VS and get them integrated with Team Build and packaged for
deployment in our organization. As the day wore on, I realized how "janky" the "elegant" solution I had been using felt
to someone new to the problem set. The supposed elegance was simply relative to the pain I had been experiencing doing
it the "old way"... there has to be a better answer for the causal SharePoint developer.

I should stop here to add a caveat that prior to this assignment I spend a year or so (on and off) working on a custom
VSIP toolkit for Visual Studio that included custom project and item templates as well as menu items, dockable tool
windows, custom build tools, etc. so I'm a bit biased towards using the built-in extensibility hooks for Visual Studio
(especially since its gotten so much easier with the 2008 release).

A year and a half or so ago we started by looking at the WSS Extensions for Visual Studio.. these were interesting
and "felt" like the right answer because "they were from Microsoft... certainly they must be the best approach". While
this sounded good (and in theory should have worked out) we ended up with a handful of issues... the first being their
very slow support for VS 2008. Secondly, we often found a webpart project that suddenly stopped working (i.e. F5
deploying) and couldn't figure out how to get it working again... there seemed to be a bit too much "magic" going on
behind the scenes. Also, It was completely unclear how one would take the resultant project and integrate it into a
build system (i.e. Team Build). I'm sure it is possible, but it didn't seem to add much value beyond the initial
development.

We then looked at STSDev (<http://codeplex.com/stsdev>). This is an interesting project that is *almost* my silver
bullet. I like the way the template projects are setup, the layout, and the work that the post-build events work
(automatically maintaining the ddf and manifest files as well as building the wsp). I have a handful of gripes with how
they layout the project structure (no root folder for the solution) and the variables they use (or don't) for certain
things. My biggest gripe is that I'm left wondering why they didn't leverage the existing, built-in templating
features for Visual Studio (i.e. why can't I go File --> Add New --> web Part). Why should I have to train developers
on yet another paradigm for creating their projects? Is their launcher really any better? I think not.  That being
said, to this day, this is still the mechanism we are using for the majority of our work, but my dissatisfaction with
the tool is the driver for this post and quest for a better end-to-end solution.

Because many of our developers were building webparts based on the SmartPart, we found ourselves looking at the
SmartTemplates project. There was some very interesting things learned from the way in which Jan implemented this, but
still some difficulties presented themselves when we tried to look at this tool relative to the larger problem of our
entire SharePoint development environment (webparts, "standard" features such as menu items or application pages,
smart parts, and Team Build).

While at PDC, I found myself talking with the Blueprint guys (<http://codeplex.com/blueprints>). Near as I can tell
this is the successor to the GAX tools and looks to be very interesting. I spent part of yesterday afternoon studying
the approach and found some very nice features (i.e. ability to update/maintain the platform via an RSS subscription).
Unfortunately, the platform is still in beta and, at least in my testing, doesn't feel ready for prime time... maybe
in a few months...

So, today I'm going to start out very basic and investigate simply building a custom project template that uses the
built-in T4 templating features of VS. The objective is to have a project template that a developer can click on that
will create a web application project, configured for development of ascx controls as smart-parts, along with a
folder structure similar to what STSDev gives you supporting the build and auto generation of wsp files, as well as
preparing the project for Team Build.