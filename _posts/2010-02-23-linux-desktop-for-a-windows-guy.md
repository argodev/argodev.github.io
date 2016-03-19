---
layout: post
category: technology
title: 'Linux Desktop for a Windows Guy'
date: 2010-02-23 00:00
tags:
- miscellaneous
- linux
- windows
redirect_from:
- /blog/2010/2/23/linux-desktop-for-a-windows-guy.html
---
I’ve found myself working quite a bit on “alternative” platforms (various distros of Linux, Mac, etc.) and have been struggling to maintain a bit of simplicity or, at least consistency amongst my work environment. I currently have a setup that is working for me and I thought I’d list how I got it working for those who care – hoping that it might help some windows guy like me who is wanting to live with a single keyboard/mouse setup. I should also state that I’m certain that there is a better way to accomplish this – I welcome suggestions.

###The Gear:
* My main machine at work is an HP workstation with 8 GB of Ram, a bunch of disk space, and three monitors (a 27” in the middle surrounded by two 21” screens).
* My main laptop is an HP tablet running Fedora 12 (this flavor was at the insistence of a certain Mr. Billings who assured me that this was the only real build). However, to Mr. Billings’ chagrin, I’m still running the Gnome desktop and not KDE like “real people” do.


###The Goal(s):
* From my main machine, dedicate at various times one full screen (likely the main one) to the Fedora desktop. I specifically wanted the full Gnome desktop and not just a singular app forwarded over X11
* Mouse/keyboard movement between the Windows desktop and the Fedora desktop should be seamless – which ever app/desktop had focus should receive the input. Specifically, I didn’t want to have to hit a key-combination of some sort to “release” the input devices from the Fedora desktop and get back to the Windows desktop.
* Simple integration points such as copy/paste should work seamlessly between them.


###The solution:

* Caveats:
  * Let me preface the following by saying I tried a number of things… a handful of Xservers such as Xming and a couple of commercial servers. I’m certain that they work to varying levels, but I didn’t have much success.
  * I also tried some options such as running DSL via qemu (screen never looked right), VMWare hosting another Linux OS as an Xclient into the laptop, etc. None of these worked as smoothly as I felt they should and they all added more overhead to my host box than I was interested in giving up
* Current Implementation
  * Installed cygwin from [http://www.cygwin.com](http://www.cygwin.com)
  * Installed Cygwin/X from [http://x.cygwin.com](http://x.cygwin.com)
  * Installed Putty from [http://www.chiark.greenend.org.uk/~sgtatham/putty/](http://www.chiark.greenend.org.uk/~sgtatham/putty/)
  * Created a putty profile for my laptop and enabled X11 forwarding.
  * Open a cygwin bash shell and type
  * xwin –nodecoration –screen 0 @1
  * At this point, it will look like nothing happened. You can verify things are started by checking in your system tray for the X server icon.
  * As I understand it, this starts the Xwin server, tells it not to give “Windows”-like borders to the windows it opens/displays from the laptop, and tells it to only use my first screen (my center one). If you just use the shortcut from the start menu you may (as in my case) get a window that spans all of your screens and can be unweildly if they run at different resolutions (the screen would work, but didn’t display properly enough to actually be useable).
  * Now, I establish a Putty connection (ssh) to my laptop and, after logging in, am at the bash shell.
  * at the laptop’s bash shell, I type:
  * gnome-session
  * with any luck (at least in my case), I get a full Fedora/Gnome desktop on my main screen and am ready to go, and have met all of the goals listed above.


Hope that helps someone!
