---
category: technology
title: 'Finally back where I want to be...'
date: 2008-05-26 00:00
tags:
- general development
- sharepoint
- tfs
- visualstudio
redirect_from:
- /blog/2008/5/26/finally-back-where-i-want-to-be.html
---
It's frustrating to me to find myself redoing things that I've done before or re-solving problems. Over the years at [Planet](http://go-planet.com/) I've been involved with different software teams each with different levels of rigor, however most all of them have had, at minimum, an automated build process of some sort (at least for the past 4 years or so). Some of these systems were elaborate msbuild driven systems while others were a cobbling together of batch scripts or PowerShell linking msbuild, [Vault](http://sourcegear.com/), [FogBugz](http://fogcreeksoftware.com/) and [Community server](http://communityserver.org/).

The customer I've been working with for the past 16 months has "bitten off" the entire TFS tree and I've been the prime developer responsible for implementing it and getting it going... all, of course, while doing "real work". Further, (nearly) all of the work we've been doing has been SharePoint focused (custom list event handlers, web parts, site definitions, etc) which means any build must generate properly formed SharePoint Solution (*.wsp) files and the approaches to doing this and handling the installation/upgrade of such are pretty varied.

This weekend I finally completed a build on a project that meets my "minimum requirements" for being a properly formed build. I'm pleased that I was able to, in relatively short order, apply it to another project verifying repeatability. Here's what we're doing:

1. All build scripts are handled by TFS 2008 (using OOTB functionality)
2. Solution manifest files and DDF files are maintained both in dev and production build by a customized version of [stsdev v1.3](http://codeplex.com/stsdev)
3. An "installer" is provided as part of the build (`<buildRoot>/Install`) that allows the back office team to simply double-click and go. We use the [SharePoint Installer](http://codeplex.com/sharepointinstaller) tool/framework to provide this function
4. All required web.config settings are handled via the feature receiver allowing them to be properly installed/removed on activation/deactivation
5. Developer-level documentation is provided for the build based on the `///` comments in the code. We use [Sand Castle](http://codeplex.com/sandcastle) to do the core generation and [Sand Castle Help File Builder](http://codeplex.com/shfb) to assist with the build script integration (I tried [DocProject](http://codeplex.com/docproject) - but it pooched vs 2008 and never worked as described - hopefully it will be more stable when it exists beta).
6. Passed Style Cop (MS Source Analysis) rules
7. Passed Code Analysis rules

I still have a ways to go prior to reaching my "nirvana"...

1. Build should automatically run code analysis (this is certainly possible, I've simply not gotten it implemented yet)
2. Build should automatically run source analysis (this is possible, I've simply not gotten it implemented yet)
3. Full testing (unit and system) on build completion - Ideally it would spin up a VM, deploy the appropriate code, execute the test battery, clean up and report on the results.

Even so, it felt good to get a respectable build out the door and to know that it was process driven and repeatable.
