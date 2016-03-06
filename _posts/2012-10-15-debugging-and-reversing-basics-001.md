---
layout: post
category: technology
title: 'Debugging and Reversing Basics 0.01'
date: 2012-10-15 00:00
tags:
- security
- grayhat
- windows
---
<small>\[Note: the title is what it is because I consider myself a n00b at this and these are likely things anyone else
already knows\]</small>

I'm always trying to learn more and recently topics in the infosec world have garnered my attention. To further my
understanding of the space, I've been reading a bit and this weekend was reading part of [Gray Hat Python: Python
Programming for Hackers and Reverse Engineers](http://www.amazon.com/gp/product/B007V2DNEK/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B007V2DNEK&linkCode=as2&tag=robgillenblog-20)
and found myself purposefully doing that which you shouldn't do when
learning a new subject: __*not following the instructions*__. You see, the author specifically indicates that the samples
were written on/tested on a Windows x86 machine and his assumption is that you will be running on the same. In my case,
I haven't run a 32-bit OS in years (since Vista was released) and I made two assumptions: 1.) It probably doesn't
matter that much and 2.) even if it does, it's probably a good thing to learn what the differences b/t 32 and 64 bit
debugging/reversing are. Well, after a few hours of playing around, I can tell you the first assumption was flat wrong
and the second is probably accurate.

The fun beings in chapter 3 where you build a simple debugger. I got stuck on the very first step which was a simple
demonstration of attaching to an existing process (calc.exe). I would run the script and simply get an error: `[*]
Unable to attach to the process.` I figured I must have done something wrong, so I poked around a bit and even diff'd
my code against the reference and still didn't see any important differences. *As a side note: If you've not yet [looked
at the errata for the book](http://nostarch.com/index.php?q=ghpython.htm#updates), __you need to do so__. There are a
number of code/bug fixes that are required to get things working.

The key came from a [blog post I came across written by A. H.](http://wordgems.wordpress.com/2010/12/18/gray-hat-python/)
where he hints that the problem may have to do with the architecture of the application I am attempting to attach to. He
suggests adjusting the error line in the script as follows:

    print "[*] Unable to attach to the process. %s" %
        FormatError(kernel32.GetLastError())

and if the error ends with "The request is not supported" you can rest sure that your problem is a 32/64 bit issue.
Unfortunately, A.H.'s solution was to simply use a 32-bit box for the rest of the testing.

###What Version of Python am I running?

The next issue that occured to me was to determine which version of Python (bit-ness) I was running. I simple search
brought up [Ned Deily's answer on Stack Overflow](http://stackoverflow.com/questions/1405913/how-do-i-determine-if-my-python-shell-is-executing-in-32bit-or-64bit-mode)
which indicated that one simple way to check would be to run the following:

    python -c "import struct;print( 8 * struct.calcsize('P'))"

You will get either 32 or 64 as a result - in my case, 32. Great. So I know that my debugging thread is a 32-bit
application, what is the image type of calc.exe?

###DumpBin

Some poking around led me to an article by [Frank Chism on the Windows HPC blog](http://blogs.technet.com/b/windowshpc/archive/2009/03/27/how-to-tell-if-a-exe-file-is-a-32-bit-or-64-bit-application-using-dumpbin.aspx)
that pointed to being able to run a tool called dumpbin to see if an exe was 32 or 64 bit. I followed the instructions
on his post, opened a VS 2010-enabled command shell and typed the following:

    dumpbin /headers c:\Windows\system32\calc.exe|findstr "magic machine"

Which resulted in:

    14C machine (x86)
        32 bit word machine
    10B magic # (PE32)

Ok... so my debugging thread is 32-bit, and the executeable that I'm running is 32-bit, so why am I unable to attach to
the thread?

###Process Explorer

At this point, I pulled up the trusty Sys Internals Process Explorer to see if it would shed any light on the issue.
From within Process Monitor, if you select the View menu and then click on "Select Columns" you can tick the box for
"Image Type" which will allow you to see for each process/executeable running what the image type is. And, after quickly
checking, I see that calc.exe is running as a 64-bit image. How in the world is this happening?

###WOW64

64 Bit Windows has a feature called the [File System Redirector](http://msdn.microsoft.com/en-us/library/aa384187%28VS.85%29.aspx)
which seems to be the root of my issues. If I understand how this works (dubious), this is a layer within the OS that
"magically" redirects you to the proper version of the application based on the calling process. For example, if a
64-bit process attempts to open the 64-bit image of calc.exe (located in `C:\Windows\System32`), it will work just
fine. However, if a 32-bit process attempts to do the same thing, it will get magically re-directed to the 32-bit
version of the application which is located in `C:\Windows\SysWOW64` (don't even ask why the folders are named the way
they are based on the versions of the applications that they house). What this means, is that if you simply hit
Windows+R and type calc, you are calling it from a 64-bit process (the shell) and therefore you get the 64-bit version
of the application. If, however, you reference calc.exe from a 32-bit process (i.e. dumpbin), you get redirected to the
32-bit version.

If you specifically need the 32-bit version (as I did to complete my testing), you can open a command prompt, navigate
to `c:\Windows\SysWOW64` and then type `calc.exe` or, you can have it launched from any 32-bit process. To see this
second option in action, open a command prompt, navigate to `c:\windows\SysWOW64` and then type `cmd.exe`. Via Process
Explorer you can confirm that you are running a 32-bit version of cmd.exe. Then navigate wherever you'd like
(i.e. `c:\`) and then type `calc.exe`. You will now get the 32-bit version of the application (and can confirm it in
Process Explorer).

From here, I can attach to the process (calc.exe as 32-bit) from my python code. This moves me forward a bit but
doesn't solve the "how do I bind to the 64-bit image" question. That will be a problem for another day.

