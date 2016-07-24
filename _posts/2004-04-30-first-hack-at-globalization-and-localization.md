---
layout: post
category: technology
title: 'First hack at globalization and localization'
date: 2004-04-30 00:00
tags:
- general development
- asp.net
redirect_from:
- /blog/2004/4/30/first-hack-at-globalization-and-localization.html
---
I've been working on a test of the .NET globalization/localization techniques for ASP.NET (v1.1) and have been having relatively mixed results.  The documentation and step-by-step examples have been a bit weak and the documentation for this area of the framework does not seem nearly as robust as other topics. This perception might be, however, just from my lack of true understanding of how this is all supposed to work and the associated terminology.

My task was to take a single html page, convert it to asp.net, and then allow it to automatically detect the user's preferred browser language “automagically” display the page (text, images, flash) in that user's language.  For the initial test we decided to support English, German, and Portuguese.  In each case we were supporting only the raw language rather than region specific contexts (i.e. [`pt`] rather than [`pt-br`] for General Portuguese rather than specifically Brazilian Portuguese).

The first thing I learned is that while the .NET framework has great support for globalizing / localizing winform apps, it is a bit lacking on (particularly GUI-based) asp.net support.  While digging into this topic, I learned that there were a handful of ways in which you could accomplish this - the two that I looked at most closely were string resource files and satellite assemblies.  Due to the relative simplicity of everything, I elected to use the string resource file method.

I figured I'd list pretty-much step-by-step what I did so that maybe the next person will have an easier time of this than I did:

1. I needed to "get a handle" on the user's preferred language.  It made the
most sense to do this in the `global.asax` file.

  1. To set the file up for this task, I added `using` statements for
  `System.Threading`, `System.Globalization`, and `System.Resources` to the
  `global.asax.cs` file

  2. I modified the `Application_Start` method to create a text-file-based
resource manager. The first parameter indicates the name or key that is the
first part of the resource files (i.e. a resources file for the English language
would have to be called `global1app.en.resources`).  The second parameter
indicates where on the disk the resources are located.  I chose this location
arbitrarily.

      Application["RM"] = ResourceManager.CreateFileBasedResourceManager("global1app", Server.MapPath("./resources"), null);


  3. I modified the `Session_Start` method to determine the user's language
preference and to store it


      Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(this.Request.UserLanguages[0]);
      Thread.CurrentThread.CurrentUICulture = new CultureInfo(this.Request.UserLanguages[0]);


2. The next task was to prepare the page for globalization/localization

  1. The first step was to convert any and all text to asp.net label controls so that I could easily change their Text properties at runtime

  2. For the images, I changed them from html `<image>` tags to `<asp:image/>` tags wherever possible so that I could set the `ImageUrl` property at runtime.

  3. For the places where we embedded Flash objects in the page, I simply created private string variables in the class and change the html to use the value of the appropriate variable for the flash URL by using `<%= VARNAME %>` embedded in the "code".  This may not be the most elegant solution as it seems to be a bit of tangled code, but it certain worked well.

  4. In the code (besides the defaults), I only had to add a using statement for `System.Resources`

  5. In the `Page_Load` method I added code similar to the following:

      ```csharp
      if (this.Page.IsPostBack != true)
      {
          this.Label1.Text = ((ResourceManager)Application["RM"]).GetString("UI_label01");
          this.Label2.Text = ((ResourceManager)Application["RM"]).GetString("UI_label02");
      }
      ```

  6. I had a line for each of my labels, images, and embedded flash objects.  This part seemed a bit tedious and "klugy" to me... I think that I could probably write a helper class that would enumerate all of the controls on a page, loop through them, and, based on the control type look to the RM for a value (or set of values) to set for the given language... I'll have to look more into that later.

3. The next task was to actually prepare the resources for the various languages.

  1. The first task was to create string-resource files that contained a list of keys and values for the text to display on the web site as well as the URLs to the various language-specific images. There are a couple of ways to create string resource files.  I struggled with this for quite some time, so let me explain...  

    1. The first is to use a text editor such as notepad and create a list of name/value pairs one line at a time.  This was initially most attractive to me because I could simply take a text file and send it to my translator and it would not be very confusing to them at all.  The file would be in the following format making it very easy to work with:

    ```
    ; this is a comment line and localization for Spanish
    UI_label01 = hola
    UI_label02 = hasta luego
    ```

    2. The second way is to create a new assembly resource file within VS.NET and set the name value pairs there.  This is nearly as easy for me (the developer) to interact with, but not quite as intuitive for the translators... especially if they do not have a good XML editor handy... and assuming they know what XML is.  I eventually chose this option due to the fact that (I must have been doing something wrong) I could never get the language-specific accent characters to display on the resultant web site using the simple text file.  I'm assuming that it had something to do with the character encoding of the original text file... maybe if I had opened notepad and created a Unicode file from the beginning things would have worked as they were supposed to.

    3.In any case, I created a resource file for each language and named it in a consistent format (this is important).  Since my app was called `global1app`, I used the names `global1app.en.resx`, `global1app.pt.resx` and `global1app.de.resx`.

  2. I then used the resgen.exe tool (from the .NET framework SDK) and “compiled“ each of these files into .resources files (i.e. global1app.en.resources, etc.)

  3. Next I created a folder in the web root called “resources“ and copied my newly-created resources files to that location.

  4. Finally, I created unique images for each language (actually, someone else created them for me) and named them in the format of <image>.<culture>.gif.  So, an image that had been logo.gif now had additional copies called logo.en.gif, logo.pt.gif, and logo.de.gif.  These names are not crucial (the URLs are in the .resources file so it really could have been anything) but I chose this naming convention to keep things consistent.

4. The last step is to test the asp.net page to see if everything works as it should.  There are a number of different ways that you can accomplish this - the following steps are the easiest that I found and assume you are using IE 6.

  1. Open internet explorer

  2. Choose Internet Options… from the Tools menu

  3. Click the button named Languages…

  4. on the dialog that opens up, click Add

  5. From the list, select Portuguese (Brazil) [pt-br] and click OK

  6. Click Add again, and select German (Germany) [de]

  7. The language displayed on the web page is based on the order in the list, so you can move the language you want to see to the top using the move up and move down buttons

  8. click ok and then ok which should put you at the browser window.
Visit the web page above (or refresh the page if you are already there) and everything should change languages.


Finally... if everything worked properly, you should see the site in different languages based on the order of the languages you chose in IE.

## Wrap-up
I'm fairly pleased with how this all worked, although I'm still going to look into the notepad-style resource file as I know that this would be easier for my translation team.  I also like the fact that if I want to add support for a new language, or update the existing support I can simply copy a new *.resources file to the web server - without recompiling the app or touching the code in any way - and everything “just works“.  The final “cool“ thing is that if I was unable to procure some of the resources for a particular culture, I can simply omit them from the resources file for that language and when the framework doesn't find the requested resource string in the current culture's resource file, it will automatically look to the resource file for the default culture (configurable in the web.config file).
