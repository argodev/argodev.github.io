---
layout: post
category: technology
title: 'Beginning Debugging'
date: 2019-02-04 17:47
tags:
- vulnerability research
- studies
---

I'm working through a few things in my desire to get smarter at low-level development and debugging and have started turning my attention to the world of Linux development and command-line tools. I've been playing around in this space for quite a while, but only with Python and other high-level languages.

I was working through a post by [Google's Project Zero on what makes a good memory corruption vulnerability](https://googleprojectzero.blogspot.com/2015/06/what-is-good-memory-corruption.html) and decided to attempt to reproduce and 'concretize' some of the examples in my environment. The first example focused on stack buffer overflows and looked like the following:

```c
void subfunc() {
    char buf[8];
    buff[16] = 1;
}

int main() {
    int run_calc = 0;
    subfunc();
    if (run_calc) execl("/bin/gnome-calculator", 0);
}
```

The idea is, that the calculator should *not* pop up however the clear/obvious buffer overflow in `subfunc()` will modify the in-memory value of `run_calc` setting it to `1` and thereby causing the calculator to appear. I had to make some initial adjustments to the code (`execl()` is a little different on Debian-based machines) and the resultant code is as follows:

```c {.line-numbers}
#include <unistd.h>

void subfunc() {
    char buf[8];
    buff[16] = 1;
}

int main() {
    int run_calc = 0;
    subfunc();
    if (run_calc) {
        execl("/usr/bin/bash", "bash", "-c", "/bin/gnome-calculator", (char *)NULL);
    }
}
```

When I first ran it (my Kali-based test machine), it simply segfaulted and quit. While this is a good thing (better to segfault/bail than to allow a stack overflow) it wasn't quite as intersting as I was hoping. After some digging, I learned that modern versions of gcc have some protections built in to help prevent buffer overflows. In order for my test demo to work as I wanted it to, I needed to disable those protections when I built my application. The following is the command I used to build it (*notice the presence of `-fstack-protector`*):

```bash
# gcc -Wall -g -fstack-protector -o test test.cpp
```

Now, when I ran the application, I am presented with a calculator. At this point, I've proved the "problem" and now I want to use a debugger to *see* the problem in action.

> I should highlight the fact that at this point I didn't *always* get a calculator. Sometimes in my testing I would just get a segfault. Other times, the calculator would duitifully pop up. __This non-determinism is a hint that something isn't working properly in the overflow__

At this point, it was time to see what was going on, and how I might adjust it to work more reliably. In my compilation switches above I used the `-g` to enable the gdb debug symbols. I then launched the debugger for the app via `# gdb test`

> Note: at this point, I did some playing around, but in order to ensure I could see exactly what was going on, I modified `subfunc()` above to set the 'proper' array locations to `0x88` - `0xFF`.

I set breakpoints (`(gdb) break test.cpp:14`) at lines 14, 18, 20 and 21



Helpful GDB commands:

- Launch and set up to debug an application named `test`
`# gdb test`

- Set various breakpoints
`(gdb) break test.cpp:14`
`(gdb) break test.cpp:18`

- run the program to the first breakpoint
`(gdb) run`

- show a portion of the stack

`(gdb) x/100x $sp`

- Other helpful/obvious commands: `next, step, contine`

0