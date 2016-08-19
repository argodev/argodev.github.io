---
layout: post
category: technology
title: 'Customizations to STSDev 1.3'
date: 2009-06-23 00:00
tags:
- conferences
- sharepoint
- .net
- build
- codestock
- teamsystem
- tfs
redirect_from:
- /blog/2009/6/23/customizations-to-stsdev-13.html
- /2009/06/23/customizations-to-stsdev-13/
---
As part of my session on Deployment and build using TFS and SharePoint for 
[CodeStock 09](http://codestock.org/) I took the source code from the STSDev 
project on CodePlex ([http://stsdev.codeplex.com](http://stsdev.codeplex.com)) 
and made a number of modifications. Some of these I would classify as clearly 
bugs, but most of them are simply adjustments to the core to fit my 
needs/desires. I’m documenting them here and providing a zip of the source for 
the benefit of those attending my session. These changes and source code are 
completely unsupported and you use them at your own risk. That being said, I 
hope that they are helpful and speed you in your integration between SharePoint 
and TFS. NOTE: unless specified, all of these changes are to the “Core” project.

1. First minor change is that I moved the solution file up one level to the 
parent folder. This is truly nothing but a nit-pick but seems to make source 
control trees happier and therefore something that I almost always do.

2. Upgraded the projects/solutions to Visual Studio 2008

3. Added an app.config file with an assembly binding redirect pushing old 
references to Microsoft.Build.Framework to utilize version 3.5.0.0. This is one 
of the changes needed to get support for .NET 3.5 working properly.

4. Changed the target framework property for the stsdev.csproj to .NET 
Framework 3.5. This change, in concert with the previous, allows the 3.5 
selection in the UI to work properly.

5. __Major Change__: Support for alternate bin paths. The 1.3 version as 
published on CodePlex always uses the compiler output in `projectdir\bin\debug` 
when assembling the *.wsp file. This happens regardless of what build 
configuration you have selected (yes, even release). This doesn’t work for TFS 
builds since the output is, by default, in a different location on the build 
server. To support this use case, the following changes were made:
  * Program.cs: Changes were made prior to calling `SolutionBuilder.RefreshDeploymentFiles` 
  to support the passing in of an additional parameter indicating the alternate 
  bin path.
  * Changed the Create method of `Builders\DeploymentFiles\CabDdfBuilder.cs` to 
  accept the alternateBinPath as an additional parameter.
  * Changed the Create method of `Builders\DeploymentFiles\CabDdfBuilder.cs` 
  such that, if an alternate bin path is provided, it will use that value when 
  adding references to assemblies rather than the otherwise-hard-coded 
  `/bin/debug/`
  * Updated the first overload of the RefreshDeploymentFiles method in 
  SolutionBuilder.cs to pass the alternate bin path to the second overload of 
  RefreshDeploymentFiles.
  * Updated the second overload of the RefreshDeploymentFiles method in 
  SolutionBuilder.cs to build the TargetPath from the alternateBinPath if 
  provided and otherwise to use the default.
  * Updated the second overload of the RefreshDeploymentFiles method in 
  SolutionBuilder.cs to pass the alternateBinPath parameter to 
  CabDdfBuilder.Create().
  * Updated the CompleteSolution method in SolutionBuilder.cs to pass an empty 
  value for alternateBinPath to RefreshDeploymentFiles since, during the initial 
  project creation, it is ok to utilize the default /bin/debug path.

6. __Major Change__: When creating a project, always create a parent solution 
directory in the same way that Visual Studio defaults to. This is helpful when 
working in a source controlled environment with multiple projects in the same 
solution. To support this feature, the following changes were made:
   *  Changed the <REFRESH /> property in 
  Resources\Common\Microsoft.SharePoint.targets.xml to utilize the $(ProjectDir) 
  variable rather than $(SolutionDir).
  *  Changed the Create method of SolutionFiles\SolutionFileBuilder.cs to accept 
  the solution directory as an additional parameter.
  *  Changed the Create method of SolutionFiles\SolutionFileBuilder.cs to change 
  the directory for where the solution file is created
  *  Changed the Create method of SolutionFiles\SolutionFileBuilder.cs to 
  reference the *.csproj file in subdirectory rather than in the same directory 
  as the *.sln file.
  *  Added  a property called ProjectDirectory to SolutionBuilder.cs to hold the 
  full path to the project directory (now distinguished from SolutionDirectory).
  *  Updated the RunCreateSolutionWizard method in SolutionBuilder.cs to set the 
  Project Directory property.
  *  Updated the InitializeSolution method of SolutionBuilder.cs to create the 
  new (child) project directory and update the location appropriately
  *  Updated the InitializeSolution method of SolutionBuilder.cs to set the 
  SolutionBuilder.TargetPath based on the ProjectDirectory property rather than 
  the SolutionDirectory value.
  *  Updated the CreateDeploymentFiles method of SolutionBuilder.cs to use the 
  proper path for the files (based on ProjectDirectory).
  *  Updated the RefreshDeploymentFiles() (first overload) method of 
  SolutionBuilder.cs to optionally set the ProjectDirectory property if it isn’t 
  already set.
  *  Updated the second overload of the RefreshDeploymentFiles method of 
  SolutionBuilder.cs to set the current directory to the value of 
  ProjectDirectory if it is set, and otherwise to use the SolutionDirectory value.
  *  Updated the second overload of the RefreshDeploymentFiles method of 
  SolutionBuilder.cs to utilize the ProjectDirectory value rather than the 
  SolutionDirectory path.
  *  Updated the LoadSolutionConfigFile method in SolutionBuilder.cs to use the 
  ProjectDirectory property and remove the pathing ambiguity that was leading to 
  incorrect path lookups.
  *  Updated the CompleteSolution method in SolutionBuilder.cs to pass the 
  SolutionDirectory property to SolutionFileBuilder.Create() since it can no 
  longer assume that the solution file should be in the same directory as the 
  project file.

7. __Major Change__: Added support for the Release|AnyCPU project configuration 
to support integration with TFS Build. In support of this feature, the following 
changes were made:
  * Added <REFRESH-TEAMBUILD> property in 
  Resources\Common\Microsoft.SharePoint.targets.xml file. The value of this 
  property is similar to that of <REFRESH /> but has an additional parameter 
  referencing the alternate bin path that TFS creates by default.
  * Added a Release target in Resources\Common\Microsoft.SharePoint.targets.xml. 
  This is targeted specifically at the TFS build and is therefore similar to the 
  ReleaseBuild target but calls the $(REFRESH-TEAMBUILD) exe rather 
  than $(REFRESH)
  * Added a “Release” value to the Configurations string array in 
  SolutionBuilder.cs. This causes the release config to be added to the 
  generated solution and project files.

8. __Major Change__: We utilize SharePoint Installer to create a nicely-packaged 
version of the resulting solution making it nearly brain-dead easy to install a 
new solution. The only real thing unique or project-specific in a SharePoint 
Installer package is the setup.exe.config file that passes a number of parameters 
to the executable allowing it to adapt for your particular solution package. 
This feature change causes STSDev to generate the initial draft of this file and 
to add it to the solution items. To this end, the following changes were made:
  * Created a new file, SolutionFiles\SetupConfigFileBuilder.cs to represent the 
  template and logic for the SetupConfigFileBuilder class.
  * Updated the CompleteSolution method in SolutionBuilder.cs to call 
  SetupConfigFileBuilder.Create and create the new config file.
  * Updated SolutionFiles\SolutionFileBuilder.cs to include a pointer to 
  setup.exe.config and thereby include it in the solution.

9. __Major Change__: We utilize Sand Castle and Sand Castle Help File Builder to 
produce developer-targeted API documents for our projects. Sand Castle Help File 
Builder needs a configuration file (xml) with a number of property values to 
configure it to run properly. This feature allows the basic file to be generated 
by STSDev and for it to be added to the solution items collection. To this end, 
the following changes were made:
  * Created a new file, SolutionFiles\SandcastleHelpFileBuilder.cs to represent 
  the template and logic for the SandcastleHelpFileBuilder class.
  * Updated the CompleteSolution method in SolutionBuilder.cs to call 
  SandcastleHelpFileBuilder.Create and create the configuration file.
  * Updated SolutionFiles\SolutionFileBuilder.cs to include a pointer to the 
  generated *.shfb file and thereby include it in the solution.

10. __Major Change__: By default, STSDev would not only generate manifest.xml 
and the ddf file, but it would add these files to the project. While in many 
cases this is innocous, it causes heartburn in a source-controlled environment. 
Firstly, purely generated files have no business being in your source tree. 
Secondly, since the user doesn’t edit them, once they are checked in, they are 
most often left as such, resulting in errors on compile because the files are 
marked as read only, preventing stsdev.exe from updating them properly. To this 
end, the CreateDeploymentFiles method of SolutionBuilder.cs has been updated to 
remove the calls to ProjectBuilder.AddSourceFile() following 
ManifestBuilder.Create() and CabDdfBuilder.Create().

11. Added an image, PlanetIcon.gif to the resources section and replaced all 
hard-coded references to africanpith.jpg with references to PlanetIcon.gif. 
This is nothing more than a branding change for the output projects and has no 
other affect on the program’s functionality. Affected files include: 
stsdev.csproj, SolutionProviders\SimpleFeatureSolutionProvider.cs 
(AddSolutionItems method), Builders\SourceFiles\FeatureBuilder.cs 
(Create method)

12. Adjusted the InitilaizeSolutionProviders method of 
UserInterface\SelectSolutionType.cs to select by default the Web Part Solution 
(C# Assembly) project type on load rather than the empty solution. This change 
is nothing other than a convenience feature during testing and use (that’s 
almost always the project type I use).

13. Adjusted the RefreshDeploymentFiles method of SolutionBuilder.cs to fix some 
seemingly obvious bugs in Console output using incorrect values.

Following the session on Friday, I’ll update this post with the actual source 
code and any other changes made during the presentation.
