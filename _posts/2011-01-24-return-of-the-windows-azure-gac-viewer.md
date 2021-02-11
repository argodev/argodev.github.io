---
category: technology
title: 'Return of the Windows Azure GAC Viewer'
date: 2011-01-24 00:00
tags:
- cloud computing
- azure
- tools
redirect_from:
- /blog/2011/1/24/return-of-the-windows-azure-gac-viewer.html
---
I’m pleased to announce that the excellent utility – the Azure GAC Viewer – is once again online and available for general use. You can access it at [http://gacviewer.cloudapp.net](http://gacviewer.cloudapp.net). This tool shows you a dynamically generated list of all of the assemblies present in the GAC for an Azure instance. Additionally, it also allows you to upload your project file (`*.csproj` or `*.vbproj`) to have the references scanned and let you know if there are any discrepancies between what you are using and what is available (by default) in Azure. You can then adjust your project file (`copy-local=true`) to ensure your application can run successfully.

<figure class="align-center">
  <a href="{{ site.url }}{{ site.baseurl }}/images/gacviewer_thumb.png"><img src="{{ site.url }}{{ site.baseurl }}/images/gacviewer_thumb.png" alt="GAC Viewer"></a>
</figure>

If you are familiar with the tool, you may be thinking “Wait! you aren’t [Wayne Berry](http://www.berryintl.com/WayneWalterBerry/), and besides, the URL has changed!” – and you would be correct on both counts. Wayne developed the tool and [posted about it back in September of last year](http://www.31a2ba2a-b718-11dc-8314-0800200c9a66.com/2010/09/missing-windows-azure-assemblies.html). Since that time, however, Wayne has accepted a position on the Windows Azure team and is unable to continue to maintaining the site full time. As a gesture of kindness to the community, he has passed the source code to me and given me his blessing to re-launch the tool.

As it stands today, the tool is nearly exactly as Wayne developed, with a few tweaks to have it use Guest OS 2.1 rather than 1.6. I’ve also added a [contributors page](http://gacviewer.cloudapp.net/Sponsors.aspx) to give credit to Wayne and to the organizations that are allowing me to maintain and keep the site online.

In the future, I hope to make the source code available on [CodePlex](http://codeplex.com/) as well as to add to the list of tools that live on the site. If you have any bugs with the current site or ideas for future changes, please feel free to [contact me](http://twitter.com/argodev).
