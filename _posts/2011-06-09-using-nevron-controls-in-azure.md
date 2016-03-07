---
layout: post
category: technology
title: 'Using Nevron Controls in Azure'
date: 2011-06-09 00:00
tags:
- cloud computing
- general development
- azure
- nevron
redirect_from:
- /blog/2011/6/9/using-nevron-controls-in-azure.html
---
I’ve been playing around with the [Nevron Controls](http://www.nevron.com/) for an Azure application I’m
building (hopefully more on that soon) and I’ve been fighting with a simple problem that I’m posting here
for my own remembrance and hopefully to help a few others.

The problem has been, that the Nevron controls worked fine when I was testing the web app directly, but
would cause the dev fabric to blow up if I tried to run it there. I even tried to simply deploy it to Azure
assuming that possibly it was a “feature” of the dev fabric – no dice.

Well, today I had some time to dig to the bottom of it and found that it was a simple problem with the way
the http handlers were registered. By default, I had the handlers registered like this:

    <system.web>
      <httpHandlers>
        <add verb="*" path="NevronDiagram.axd"
          type="Nevron.Diagram.WebForm.NDiagramImageResourceHandler"
          validate="false"/>
        <add verb="GET,HEAD" path="NevronScriptManager.axd"
          type="Nevron.UI.WebForm.Controls.NevronScriptManager"
          validate="false"/>
      </httpHandlers>
    </system.web>


However, as [Shan](http://social.msdn.microsoft.com/profile/shan%20mcarthur/?type=forum) points out in
this post: <http://social.msdn.microsoft.com/Forums/en/windowsazure/thread/0103ca2d-e952-4c28-8733-47630535c05c>,
you need to use the newer IIS 7 integrated pipeline. A closer look at the official Nevron samples, shows that
they accounted for this and I simply missed it. The setup should be something like this:

    <system.webServer>
      <validation validateIntegratedModeConfiguration="false"/>
      <handlers>
        <add name="NevronDiagram" preCondition="integratedMode"
          verb="*"
          path="NevronDiagram.axd"
          type="Nevron.Diagram.WebForm.NDiagramImageResourceHandler"
          />
        <add name="NevronScriptManager"
          preCondition="integratedMode"
          verb="*"
          path="NevronScriptManager.axd"
          type="Nevron.UI.WebForm.Controls.NevronScriptManager"
          />
      </handlers>
    </system.webServer>

Notice in particular that not only is the structure a little different, the declarations are under the
`system.webServer` node rather than the `system.web` node.
