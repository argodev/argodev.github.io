I am preparing to give a talk/introduction to the MPS SDK at the end of this week based on the outline below. I
thought I'd list some of the thoughts/comments here under each of the points as a general resource for anyone
interested. In this post, I'll list my outline and then expand on the first points with subsequent posts expanding on
the remaining points.

1. Introduction to the SDK (scope, purpose, supported platforms, etc.)
2. Installation (prerequisites, potential "gotchas", etc.)
3. VS 2005 SDK Overview
4. Item templates
5. Provider Templates/Wizard/BaseClass/Intro to sample providers
6. Intellisense (& XSLT Extensions)
7. MPS SDK Options panel
8. Introduction to the Named Procedure Browser
9. Introduction to the Procedure Step Browser window & the Content Window
10. Introduction to the Find All Procedure References window
11. Code-window context menus
12. Solution Explorer context menus
13. Future plans/goals


###Introduction to the SDK (scope, purpose, supported platforms, etc.)
My [previous post on this topic](//robgillen.com/technology/2006/new-sdk-for-the-microsoft-provisioning-system) (as
well as [one written by Conrad](http://weblogs.asp.net/conrad/Microsoft-Provisioning-System-_2800_MPS_2900_-SDK-Beta-1-is-now-available)
or [by Mike](http://blogs.msdn.com/b/mkostersitz/archive/2006/05/25/607296.aspx)) covers a good bit of the
introductory-style information for the SDK. Essentially the goal is to provide MPS developers (product team, ISVs and
ISP in-house developers) a set of tools to ease the task of building applications that consume as well as extend the
Microsoft Provisioning System. This has been a long-time gripe of every developer I've spoken with - the platform is
interesting but seems "klugy" to work with. There is no debugger, no designer, and no real developer guidance.
Thankfully that (well... some of it) is about to change.

The SDK is being made available as part of the on-going solution set Microsoft has been providing for the Hosted
Exchange, Windows-based Hosting and now ISV customers. A [beta is now available]
(http://download.microsoft.com/download/f/b/9/fb905eb4-d992-40e3-b0bc-cdb1996a1a10/Microsoft%20Provisioning%20System%20SDK-%20Beta%201.zip)
and, while much has changed between the beta and the final version, the current drop should give you a good idea of
what the final product will do.

The primary target platform is Visual Studio 2005 and the .NET Framework v2 although there is some support for Visual
Studio 2003 and the .NET Framework v1.1. The tool set includes most everything you need to build solutions based on MPS
including templates, provider wizards, intellisense, samples, integrated help (coming soon) and other tools. The SDK
does not currently include a namespace debugger (you can still use TraceView) or a visual designer for building named
procedures, but it does include some tools that provide great assistance to the namespace developer including
drag-and-drop calling of procedures, integrated procedure "dis-assembler", sample generator, and context menu-based
"execution" of procedures saving you the time of having to look up the documentation and hand-craft the Xml request
just to test a simple call.


###Installation (prerequisites, potential "gotchas", etc.)
A normal installation machine would be a developer box running Windows Server 2003 SP1 or greater, have either Visual
Studio 2003 or Visual Studio 2005 (preferred) and the MPS client installed. Depending on which version of Visual Studio
is installed, the appropriate components for that version will be deployed (you can have both installed and all
components/samples will be installed).

One thing to note is that if you are installing the Visual Studio 2005 version, you should ensure that you have run
Visual Studio at least once prior to installing the tools... this allows the SDK installer to read the registry keys
necessary to properly locate/deploy the support files.

For Visual Studio 2005, the project templates are currently deployed *per user* rather than for all users... if you
need the templates available for other users you will need to copy the zip files from
`C:\Documents and Settings\<your alias>\My Documents\Visual Studio 2005\Templates\ProjectTemplates\<language>\Microsoft Provisioning System`
to the same location under their "My Documents" folder.

For Visual Studio 2005, the add-in registration file is currently deployed *per user* rather than for all users... if
you need the add-in available for other users you will need to copy the file named `Microsoft.Provisioning.Sdk.Addin` from
`C:\Documents and Settings\<your alias>\My Documents\Visual Studio 2005\Addins` to the same location under their
"My Documents" folder.

If the MPS client is not installed and/or the machine is not a member of a valid (read: "working") MPS
environment/domain, many of the integrated tools will not function properly... if you have troubles, make sure you can
perform "normal" MPS operations from the box outside of the VS environment.
