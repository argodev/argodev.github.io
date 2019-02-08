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

```c
#include <unistd.h>

void subfunc() {
    char buf[8];
    buff[16] = 1;
}

int main() {
    int run_calc = 0;
    subfunc();
    if (run_calc) {
        execl("/bin/bash", "bash", "-c", "/snap/bin/gnome-calculator", (char *)0);
    }
}
```

When I first ran it (my Ubuntu-based test machine [18.04]), I received the following error message:

<img alt='Stack Smashing Protection' src='/images/stack_start00.png' class='blogimage img-responsive'>

While this is a good thing (better to bail than to allow a stack overflow) it wasn't quite as intersting as I was hoping. After some digging, I learned that modern versions of gcc have some protections built in to help prevent buffer overflows. In order for my test demo to work as I wanted it to, I needed to disable those protections when I built my application. The following is the command I used to build it (*notice the presence of `-fno-stack-protector`*):

```bash
# gcc -Wall -g -fno-stack-protector -o test test.cpp
```

Now, when I ran the application, I am presented with a calculator. At this point, I've proved the "problem" and now I want to use a debugger to *see* the problem in action. I should note, however, that running the application multiple times resulted in different results. _Sometimes_ I would get a calculator, other times, I'd get a segfault. __This *non-determinism* points to a problem with the assumptions being made given the current stack layout.__

At this point, it was time to see what was going on, and how I might adjust it to work more reliably. In my compilation switches above I used the `-g` to enable the gdb debug symbols. I then launched the debugger for the app via `# gdb test`

> Note: at this point, I did some playing around, but in order to ensure I could see exactly what was going on, I modified `subfunc()` above to set the 'proper' array locations to `0x88` - `0xFF`. The updated listing is as follows:

```c
#include <unistd.h>

void subfunc() {

  // this is the buffer we are going to overflow...
  char buf[8];
  int dummy_val;
  int i;
  dummy_val = 0x88;

  // place known values in the proper parts of the buffer to make
  // it easy to find in the stack
  for (i = 0; i <= 8 ; i++) {
    // set to 88, 99, AA, BB...
    buf[i] = (dummy_val + (i*17));
  }
  
  // this is where we overflow... and overwrite run_calc
  buf[16] = 1;
}

int main() {
  int run_calc = 0;
  subfunc();
  if (run_calc) {
    execl("/bin/bash", "bash", "-c", "/snap/bin/gnome-calculator", (char *)0);
  }
}
```

I set breakpoints (`(gdb) break test.cpp:24`) at lines 24, 19, 20 and 26. I then ran the program (`(gdb) run`) and stopped just before we did anything with `subfunc()`. The stack at this point, is shown below:

<img alt='Initial Stack' src='/images/stack_start01.png' class='blogimage img-responsive'>

You can see the initial value of `run_calc` is highlighted and currently `0`.

Next, I stepped into the `subfunc()` and stopped right after setting the (within-bounds) normal values of the array. You can see them highlighted in the image below:

<img alt='Stack Array' src='/images/stack_start02.png' class='blogimage img-responsive'>

> Note: I should mention that I wasted a ton of time at this point because my view of the stack didn't work quite the way I expected. Up to this point, I've been using `x/24x $sp` to see the last 24 slots of the stack... however when I did this hear, I would never see the values of the array that I had overwritten. The displayed stack (when using the command just mentioned) started at `0x7fffffffdbe0` and really it should have started at `0x7fffffffdbd0`. In order to actually see the portion of the stack I wanted to, I had to run the following command: `x/24x 0x7fffffffdbd0`

While the memory location of the array is obvious, an offset of `16` (from the original sample) is definitely not going to reach where we want it to. I counted the offsets and came up with a new offset value of `44`. I re-compiled and re-ran gdb. Now, when we run the application and stop just after the overflowed array set, you can see that the stack's version of `run_calc` is now set to `1`.

<img alt='Overflowed Stack' src='/images/stack_start03.png' class='blogimage img-responsive'>

At this point (with the modified overflow value of `44`), I get the calculator popped every time I run the application.

<img alt='Calculator' src='/images/stack_start04.png' class='blogimage img-responsive'>


Finally, I wanted to see if I could understand the stack smashing protection a bit better so I compiled the app again without the `fno-stack-protector` flag and, while it let me run through the `subfunc()`, it aborted when returning into the `main()` function. This led me to believe that some sort of state is stored prior to calling the subfunction and then validated upon return. The image below seems to support this fact as all of the memory slots in this image are the same as the above with the exception of the highlighted areas:

<img alt='Stack Smashing Protection' src='/images/stack_start05.png' class='blogimage img-responsive'>

Checking the gcc main page, we learn the following:

> -fstack-protector: Emit extra code to check for buffer overflows, such as stack smashing attacks. This is done by adding a guard variable to functions with vulnerable objects. This includes functions that call "alloca", and functions with buffers larger than 8 bytes. The guards are initialized when a function is entered and then checked when the function exits. If a guard check fails, an error message is printed and the program exits.

This leads me to believe that if the buffer were smaller, the overflow *might* still work... something to check later.


## Helpful GDB commands:

- Launch and set up to debug an application named `test`

  `# gdb test`

- Set various breakpoints

  `(gdb) break test.cpp:14`
  `(gdb) break test.cpp:18`

- run the program to the first breakpoint

  `(gdb) run`

- show a portion of the stack

  `(gdb) x/100x $sp`
  `(gdb) x/24x $sp`

- Other helpful/obvious commands:
  
  `next, step, contine`

