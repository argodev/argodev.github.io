I’ve recently received clearance to discuss a project I’ve been working on for quite awhile – a new SDK for the
Microsoft Provisioning System. This is something that has been a goal of mine for a number of years, and if you have
done any significant development for/with MPS you will be glad to hear that the developer tool set is finally going to
be shipping (no, don’t ask me when – but it shouldn’t be too long).

There are a number of things still missing from the SDK (things we wanted to include but were simply unable to for
time or other reasons) but I’m very pleased with the feature set and feel that this will provide a great step forward
for MPS developers.  In future posts, I’ll dive a bit deeper into the various feature sets, but in this post I figured
I’d simply provide an overview of the tool set.

Support for Visual Studio 2003 - in general, the support for VS2K3 is not as extensive as with VS2005 - users of this
development platform will have access to a project template for building C# providers, Intellisense for authoring MPS
Namespaces and Requests, and some general template files.

Support for Visual Studio 2005 – Because of the improvements that the Visual Studio team has made to the extensibility
model in VS2K5, we were able to integrate a number of features into this platform very easily. The VS2005 edition of
the SDK is a superset of the 2K3 SDK adding an updated provider base platform (more on this later), support for VB.NET
providers (and other .NET languages – I’ve personally tested C++.NET and J# – although project templates are only
provided for C# and VB.NET), integrated namespace/procedure browser, procedure dissassembler, context menus allowing
the user to submit requests and register namespaces directly from the VS code window, the ability to generate samples
for methods, drag-and-drop support for quickly building namespaces, sample providers, integrated help, and much more.

<img alt='MPS SDK' src='/assets/images/sdk01.jpg' class='blogimage img-responsive'>