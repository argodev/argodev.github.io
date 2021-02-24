---
title: "Learning Assembly Language"
permalink: /vsstudy/assembly/
excerpt: "Books, Tools, Links and Other Resources"
last_modified_at: 2021-02-24
published: True
toc: true
header:
  overlay_image: /assets/images/assembly.png
  overlay_filter: rgba(0, 0, 0, 0.6)
  image_description: "Sample Assembly Language Script"
---
## Introduction

It seems that nearly all of the tools used in Vulnerability Science generate (or expose) assembly language at some point. You see it in stack traces, you see it in `gdb` outputs, you see it in `Ghidra` outputs, you see it all over the place. If you want to be craftsman in vulnerability science, you need to get comfortable with assembly. Unfortunately, most of my knowledge in this area dates back to my EE classes in college.

What follows on this page is not a lesson in assembly, nor a series of specifically helpful tutorials. Instead, it is a list of resources that I have found while attempting to develop my skills in this area. Many of them I have either read, viewed, or worked through. Some are posted for my future evaluation. Where appropriate, I'll provide some notes and commentary.

## Books of Interest

* [Assembly Language Step by Step](https://amzn.to/3946Wpi), Jeff Duntemann. This is an older book, originally written in 1989 and updated a few times, but it is *worth it*. The link here is to the third edition, published in 2009, which seemed quite dated when I was reading it in 2020/2021. I made myself slow down and attempt to ingest it, even knowing that it was focused on 32-bit systems and I was really interested in the 64-bit variety. The author does a great job of helping you understand what is happening at the lowest levels inside the machine, and why it matters. If you read this, you may _feel_ like you are wasting your time, but this falls in the _"Trust the process"_ category... read it, understand it, more modern books/posts/etc. will make a ton more sense to you.
* [Beginning X64 Assembly Programming](https://amzn.to/2X9lwGz), Jo Van Hoey
* [Modern X86 Assembly Language Programming](https://amzn.to/3rUmNj2), Daniel Kusswurm
* [Programming with 64-Bit ARM Assembly Language: Single Board Computer Development for Raspberry Pi and Mobile Devices](https://amzn.to/3hFrPez), Stephen Smith
* [Raspberry Pi Assembly Language Programming: ARM Processor Coding](https://amzn.to/38YNj1X), Stephen Smith
* [The Art of Assembly Language Programming](https://www.plantation-productions.com/Webster/www.artofasm.com/Linux/index.html)

## Videos of Interest

* [Why should I learn assembly language in 2020? (complete waste of time?)](https://www.youtube.com/watch?v=iYRl50gtprA), [Jacob Sorber](https://www.youtube.com/channel/UCwd5VFu4KoJNjkWJZMFJGHQ) This is a short (~6 min) explanation of *why* learning assembly language is worth your time. It is well-produced, engaging, and worthy it if you find yourself asking if you should.
* [Assembly Language Tutorial on Raspberry Pi](https://www.youtube.com/watch?v=ViNnfoE56V8&list=PLGLfVvz_LVvQu9IwUcpn8KOZsOvoHx8sU), [Derek Banas](https://www.youtube.com/channel/UCwRXb5dUK4cvsHbx-rGzSgw). This is a 4-part series that introduces you to assembly using the common/easy-to-find Raspberry Pi. The entire series will take about 2.5 hours to watch if you don't stop to work through any examples.
* [x86 Assembly: Hello World!](https://www.youtube.com/watch?v=HgEGAaYdABA), [John Hammond](https://www.youtube.com/channel/UCVeW9qkBjo3zosnqUbG7CFw). This is a short (~15 min) clip that walks through a simple assembly-language program while the author is somewhat learning himself. This is quite beginner, and not entirely correct, but it is an easy watch and may help get you in the right "head space" for some of the others.
* [x86_64 Linux Assembly](https://www.youtube.com/playlist?list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn), [kupala](https://www.youtube.com/user/khoraski). If you are only going to spend time on one video series, I'd start here (well, after the "why should I" at the beginning of this list). This is a series of 13 videos, most of them short (4-15 min), walking through a collection of assembly language topics. The series is focused on `x86_64` Linux and will give you a heads-up on things you need to know to get started writing and understanding assembly. What I think is cool about this series, is that it gets into a number of not-quite-as-but-still-basic topics such as:
   * Jumps, Calls, Comparisons
   * Registiers as pointers
   * Getting User Input
   * Math Operations
   * Subroutines
   * Macros
   * Command Line Arguments
   * Reading/Writing files

## Tutorials

* [NASM Assembly Language Tutorials](https://asmtutor.com/)


## Cheat Sheets 

* [x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)
* [x64 Cheat Sheet](https://www.cs.tufts.edu/comp/40/docs/x64_cheatsheet.pdf)
* [x86-64 Reference Sheet (GNU assembler format)](http://www.cs.cmu.edu/afs/cs/academic/class/15213-s20/www/recitations/x86-cheat-sheet.pdf)
* [ARM 32-bit Assembly (Azeria-Labs)](https://azeria-labs.com/downloads/cheatsheetv1.3-1920x1080.png)
* [x64 NASM cheat sheet](https://gist.github.com/justinian/385c70347db8aca7ba93e87db90fc9a6)


## Miscellany

### NASM Assembly Language Tutorial

There's a nice [series of lessons and walk-throughs](https://asmtutor.com/) created by [Daniel Givney](https://danielgivney.com/). You can access them at [https://asmtutor.com/](https://asmtutor.com/)

### 40 Basic Practices in Assembly Language Programming

A [list of best practices](https://www.codeproject.com/Articles/1116188/40-Basic-Practices-in-Assembly-Language-Programmin) for assembly programming developed by [Zuoliu Ding](https://www.codeproject.com/Members/Zuoliu-Ding).

### Examples of Assembly

A [simple search on GitHub](https://github.com/search?q=assembly+language) provides many examples to review.

### C Code to Assembly

Easy way to get `clang` to give you the assembly-language version of your c-language program:

```bash
clang -S hello.c
```

This will yield a `*.s` file (check out the `scratch` directory)


### System Call Definitions

System calls are defined in `unistd.h` (64-bit) and `unistd_32.h` in `/usr/include/x86_64-linux-gnu/asm/` on Ubuntu


### 32-bit ASM on 64-bit Host

Building a 32-bit hello-world on 64-bit host requires being explicit about the types. Many 32-bit only books exclude this as they were written on 32-bit machines and this was not a requirement at the time.

```bash
# create the 32-bit object file
nasm -f elf32 -o hello_world.o hello_world.asm

# run the linker and create the executable
ld -m elf_i386 -o hello_world hello_world.o

# run the executeable
./hello_world
```