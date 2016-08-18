---
layout: post
category: technology
title: '.NET Framework 1.1 sp1 and MPS - the real story'
date: 2004-09-24 00:00
tags:
- provisoning
- .net
- mps
redirect_from:
- /blog/2004/9/24/net-framework-11-sp1-and-mps-the-real-story.htm
---
I've been contacted recently by a number of people regarding a recent scare about installing the service pack 1 for the .NET framework 1.1 on a system running MPS.  This issue has been fueled by the fact that Ensim had released a concern about the patch for their customers, and there have been a number of people reporting problems using the Configuration Wizard for MPS with the service pack.  So, let's get the facts out.
 
__The Facts__
__Ensim Unify__: As of the writing of this blog post (9/29/04), Ensim has issued a warning against installing the service pack on boxes running their Unify product (see this release here: http://kbold.ensim.com/TWKB/ViewCase.asp?QSRuleID=1039
).  This is an issue with their software that they are actively working on addressing.
 
__Microsoft for Solution for Windows Based Hosting v2.5 with Hosted Exchange 2003__:  The *only* issue with the service pack and the Microsoft solution is the configuration wizard.  This wizard is only used during setup, so if your environment is already set up, you have no worries.  For those of you who are needing to install the product, let me take a minute to explain the work around….
 
There is a small issue in the `Configurator.exe.config` file that was ignored by the .NET framework prior to SP1.  After you install SP1, the framework does a validation check on this configuration file as the application loads.  Because of this issue, you receive an error and the application closes.  The work-around is to remove the configuration file (simply delete it - by default it installs to `C:\Program Files\Microsoft Hosting\Provisioning\ConfigurationWizard`) and re-run the application.  I know that this seems odd, but it should resolve the problem.  I've spoken with the team at Microsoft, and they are working to release an "official" patched version that will eliminate the issue and should be available soon. 
 
The net-net is that MPS and the Windows solution runs without issue with the service pack installed and none of the providers are demonstrating any problems.
 
__Support links:__

* [http://groups.msn.com/provisioning](http://groups.msn.com/provisioning)
* [http://www.asp.net/Forums/ShowForum.aspx?tabindex=1&ForumID=167](http://www.asp.net/Forums/ShowForum.aspx?tabindex=1&ForumID=167)
