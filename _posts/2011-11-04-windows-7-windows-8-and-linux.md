---
layout: post
category: technology
title: 'Windows 7, Windows 8, and Linux'
date: 2011-11-04 00:00
tags:
- general development
redirect_from:
- /blog/2011/11/4/windows-7-windows-8-and-linux.html
---
This post may not be of interest to everyone, but I finally got my laptop configured the way I want it and thought
I’d document what I did in case anyone else finds themselves in a similar position. It took me 4 or 5 full
install/repeat processes to get this right (don’t ask…) so this description is where I ended up.

Let’s start by discussing some of my requirements:

1. It needs to run Windows 7. The software we use to support our secure email platform is only available on
Windows or Mac, and I can’t meet my other requirements on a Mac.

2. It needs to run Linux ([Scientific Linux](https://www.scientificlinux.org/) is the distro I’m using).

3. It needs to run Windows 8: This will be for dev/testing and not my primary OS

4. The Windows 7 partition must be encrypted using BitLocker

5. The Linux partition must be encrypted

6. I should be able to easily update Windows 8 without overly affecting the other platforms

7. Performance should be as good as possible – I don’t want to do this all in VMWare from within a main host OS.

9. While not directly related, the system should be easily bootable from external media (i.e. usb stick) to
temporarily run network utilities or other tools (another strike against a Mac)

<img alt='EliteBook' src='/images/EliteBook.jpg' class='blogimage img-responsive'>

The laptop I’m using is an HP EliteBook 2760p. I selected this unit as I wanted to be able to do some
touch & tablet development and it works as a solid convertible as well as having a decent touch screen. The
machine comes with a modest 4GB of RAM (I might upgrade this) and a 300GB hard drive.

I started by performing a normal Windows 7 installation. During the phase where you select a disk, created
three equally-sized partitions and then chose the first one for the installation. Windows split the first
partition giving me a small boot partition (~100 MB) and then the remaining as my “C” drive. I continued
through the install, applied drivers, patched it, etc. and everything was running fine. Note that I did
*not* run the BitLocker configuration at this time.

<img alt='scientificlinux' src='/images/scientificlinux.png' class='blogimage img-responsive'>

Next, I installed Linux. I learned from earlier tests, that I didn’t want to install GRUB to my Master Boot
Record (MBR) as that tends to mess up your ability to use BitLocker. Instead, I inserted a memory card (SD
card actually), and created a 200 MB /boot partition on it (EXT4) and selected it as the location for the
GRUB installation. I then created a EXT4 partition for the / mount point that used the third partition on the
main disk and was encrypted. This lets me then end up with the option of controlling whether or not I boot
into Linux or not by simply inserting the memory card or not – actually quite handy for my use case. The SD
card is a good option on this machine because it sits in such a way that, when inserted, is barely noticeable
and can be left inserted for weeks at a time without getting caught on anything.

<img alt='Windows 8' src='/images/windows8.jpg' class='blogimage img-responsive'>

Windows 8 was the next install, but I decided to install it a bit differently in order to possibly give me
greater flexibility in the long run. Rather than installing directly onto my “middle” partition, I booted
into Windows 7, formatted the partition as NTFS, and created a VHD file (expandable). Then following the
instructions here and here, I mounted the VHD during installation and installed Windows 8 to that (virtual)
volume.

While I’m glad to have the opportunity to play with Windows 8, I don’t want it to be my default, so I
changed the bootloader to use Windows 7 as the default (unless, of course, the SD card is inserted which
will preempt the Windows boot process and take me directly to Linux.

Finally, I switched back to Windows 7 and ran the BitLocker tools to encrypt that partition.

Finally, I’m done with my laptop and my configuration is complete. The following is the disk/partition
configuration on my machine. In this diagram, Disk 1 is the SD card I’m using to control my Linux
installation.

<img alt='Disk Partitions' src='/images/DiskPartitions.png' class='blogimage img-responsive'>
