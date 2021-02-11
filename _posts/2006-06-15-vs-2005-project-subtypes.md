---
category: technology
title: 'VS 2005 Project Subtypes'
date: 2006-06-15 00:00
tags:
- general development
- vs2005
redirect_from:
- /blog/2006/6/15/vs-2005-project-subtypes.html
---
I’ve had the opportunity lately to work on a project that needed to generate some code for a project based on a given file within the project and then include/add those files to the project for inclusion during build. We spent a good bit of time looking at the various options such as custom MSBuild tasks, add-ins, VSPackages, etc. and finally settled on a Visual Studio Package that implemented a project subtype, a custom project property page, and a custom tool (single-file generator).

The documentation in the VS 2005 SDK continues to improve as does the general toolset. For those of you who aren’t aware, the SDK team has moved to a very aggressive release schedule posting new builds every few months in the CTP/RTM model. Of particular note has been the improvements to the managed package framework - MPF (no, not Microsoft provisioning framework). These improvements have made it possible for non-C++ aficionados such as myself to write some interesting tools fully integrated into the platform.

I used the `ProjectSubType` sample (installed by default to `C:\Program Files\Visual Studio 2005 SDK\2006.04\VisualStudioIntegration\Archive\CS_Samples\ProjectSubtype\ProjectSubtype`) provided in the SDK as my guide for much of the features I needed to implement. I encountered a few “gotchas” along the way (thanks to those who lent support) and I am going to document them here for my own sake (easy to find in the future) as well as maybe helping others who find themselves hitting the same issues. In this post I’ll cover a few of the items I hit and I’ll cover some others in subsequent posts.

Creating a project sub-type seemed incredibly easy... simply modify/include the files I wanted in a `/templates/projects` directory (this really can be anywhere so long as the path is properly registered for your package in the registry) and I was ready to go. The SDK documentation is really pretty clear on this and you will find yourself with a custom project (in my case a flavor of a C# class library) in no time at all.

The first place where things got a little hairy was the custom properties page. I actually took the samples from the `ProjectSubType` project and had a custom page in no time, however it had one major drawback as it related to my project – the properties it saved were configuration specific (i.e. debug/release) rather than being configuration ambivalent as I wanted. I spent some time fighting through things and finally ended up doing the following...

1. On my project sub-type (`project.cs`) I implemented the `IPersistXMLFragment` interface nearly identically from the SDK sample documents. The only thing I did differently is that I did not pass the request on to other project sub-types (I don’t intend for anyone to sub-type my project).

2. I created an interface (say `IMyCustomProperties`) that defined accessors for the properties I wanted to expose and then implemented the interface on my flavored project (`project.cs`).

3. The default sample shows (in the implementation of `IVsHierarchy`) the `GetProperty` method removing one property page and then adding another. What I learned, is that the case branch in which they remove a property page (`__VSHPROPID2.VSHPROPID_PropertyPagesCLSIDList`) is actually where you want to add your page if you want it to appear and be configuration independent. As in the following...

```c#
protected override int GetProperty(uint itemId, int propId, out object property)
{
    switch (propId)
    {
        case (int)__VSHPROPID2.VSHPROPID_PropertyPagesCLSIDList:
        {
            // Get the list from the base class
            ErrorHandler.ThrowOnFailure(base.GetProperty(itemId, propId,
                    out property));

            // Add our WES Property Page
            Debug.Assert(typeof(IPropertyPage).IsAssignableFrom(
                typeof(MyPropertyPage)),
                "Property page should implement IPropertyPage");
                property += ';' + typeof(MyPropertyPage).GUID.ToString("B");

            //property = propertyPagesList;
            return VSConstants.S_OK;
        }
    }

    return base.GetProperty(itemId, propId, out property);
}
```

Where `MyPropertyPage` is a local class that inherits from `PropertyPageBase.PropertyPage` (provided as shared-source in the SDK).

The item I struggled with for quite some time was the implementation of `MyPropertyStore` – a class for interacting with the data store and implementing `PropertyPageBase.IPropertyStore`. The sample project implements this file, however it is once again interacting with configuration-specific data and the way in which it retrieves the main “data object” (casting the data object in the `Initialize()` method as `IVsCfg`). NOTE: The `Initialize()` method is called by the `SetDataObjects()` method that is implemented in the `PropertyPageBase.PropertyPage` class. I knew that what I really wanted was to get the `IMyCustomProperties` interface from my project object so I could access my custom properties. I tried a `QueryInterface` on the data variable using all sorts of classes and interfaces and was patently unsuccessful until someone pointed me in the correct path... the proper procedure when using project-based properties is to cast the object as an `IVsBrowseObject` first, and then you can call GetProjectItem` to retrieve the `IVsHierarchy` object, from which you can finally obtain the custom interface you wanted…

```c#
void PropertyPageBase.IPropertyStore.Initialize(object[] dataObject)
{

    // If we are editing multiple configuration at once, we may get multiple objects
    foreach (object data in dataObject)
    {
        if (data is IVsBrowseObject)
        {
            // get the Browse object...
            IVsBrowseObject browse = data as IVsBrowseObject;

            // Get the project item...
            IVsHierarchy project;
            uint count;
            browse.GetProjectItem(out project, out count);

            // now get/store the IMyCustomProperties object
            this.myCustomProperties = (IMyCustomProperties)project;
        }
        else
        {
            Debug.WriteLine("Not IVsBrowseObject");
        }
    }
}
```

This was the trick that allowed me to finish my implementation of the custom properties page, and to have data read from the `.csproj` file, displayed in a custom properties tab, edited by the user, and then persisted to the `.csproj` file.

I’ll eventually post a full sample, but in a follow-up post I’ll illustrate how I was able to read these properties in my custom single file generator.
