---
layout:     post
title:      Fighting with Hidden Characters
date:       2015-03-11 12:00:00
categories: technology
tags:       
- tr
- sed
- analysis
---

One of the projects I'm currently working on involves performing analysis over a number of different log files from an
array of different systems. Each system has its own format/structure/whatever and we are trying to glean important
information from the unified view of that data.

### The Problem
Many of the files handed to us have a problem in that they are not in a standard format suitable for analysis - those of
you who do this for a living know that this is more often the rule rather than the exception. In this particular case,
rather than having a single line of the file represent a single record, the rather long data lines were broken up at
seemingly arbitrary locations which made it a bit difficult to process using standard tools. After studying the data and
eventually reviewing one of the files in a hex editor, it became clear that the actual record boundaries were marked
with `0D1E0A` (CR + RS + LF). The "bogus" line breaks were marked by `1E0A` (RS + LF) preceded by `FAKE_EOLN`.

I could have written a python, perl, java, or c# program to do a find/replace on the various characters and been done,
but I really wanted to be able to use existing tools as much as from the command line as possible. I'm all for using the
right tool for the job, but this felt like something a one-liner on the shell was best for.

### Failed Attempt
My first attempt, after much wailing and nashing of teeth, was the following:

    sed -i.bak -e ':a;N;$!ba;s/FAKE_EOLN\('$'\036''\)\n//g' \
        -e 's/\r\('$'\036''\)//g' t.csv

I liked this version as it utilized a single tool, operated on the file in place, and seemed to work fine. However, for
whatever reason, it failed when I tried it on the real file (over 2GB). It worked great on the smaller test files but
simply didn't function on the large files (would complete without having actually performed the work). I tested the two
commands independently and it appears that it was the "magic" that I was doing in the first command (combining lines)
that was the problem as the second part, when run in isolation, worked fine on the full files but the first didn't. For
those of you who care (as well as for my own reference) I've described what that line does at the bottom of this post.

### Current Solution
I next re-thought about the problem... how could I make it fast, simple, and reliable. As such, a re-thinking of the
problem led to the following:

- the "Windowsy" CR char is the one thing that accurately marked the end of the record.
- I could remove all RS and LF chars and then come back and replace the CR with LF and I'd have one line per record
- Still needed to remove the "FAKE_EOLN" strings

A little bit of poking around and work led me to the following:

    tr -d '\012\036' < t.csv | tr '\015' '\012' | \
        sed 's/FAKE_EOLN//g' > t1.csv

where:
- `t.csv` is the input file
- `t1.csv` is the output file
- `\012` is the octal value of a LF character
- `\036` is the octal value of a RS character
- `\015` is the octal value of the CR character

You probably know that `tr` replaces individual characters and works on a byte stream level (rather than individual
lines as `sed` does). This means I can easily translate/drop individual chars from the byte stream and don't have to
worry about line breaks messing me up (this was the purpose of the ultimately unsuccessful `:a;N;$!ba;` mess in the sed
example). Unfortunately, you cannot replace/remove a full string so I had to still use sed for that last part.

The approach above "fixes" the problem and only takes about 13 seconds to run on a 2.2 GB file with around 1.8 million
actual rows of data (had almost 12 million lines prior to processing)

### Miscellany
Because it took me so long to work out the first time combined with the fact that I'm relatively new to sed, I wanted to
document exactly what was going on in the initial (although failed) attempt.

    sed -i.bak -e ':a;N;$!ba;s/FAKE_EOLN\('$'\036''\)\n//g' \
        -e 's/\r\('$'\036''\)//g' t.csv

The following are general statements about the above:
- There are two commands (strung together by `-e` operations) - more on these in a minute.
- the file will be operated on in-place with a backup being made at `filename.bak` (this is the `-i.bak`)
- the file to be processed is `t.csv`

Command #1:
- Goal: Remove all instances of `FAKE_EOLN` followed by a RS character and a LF character thus removing the junk entry
and recombining the two lines into one. For whatever reason, an individual record is broken up into many lines using
this combination of characters

- this one is a bit tricky because sed only works on individual lines, but this step needs to actually remove a line
break (not normally 'visible' to sed)

- we create a label via `:a`

- we append the current and next line to the pattern space via `N`

- If we are before the last line, we branch to the created label `$!ba` (`$!` means not to do it on the last line)

- then the substitution kicks in, removing any instance of both an RS and LF characters.

> **Note:** after reading the above, it makes perfect sense as to why this approach worked well on small files yet
> failed for larger ones. The branching step (`$!ba`) would effectively build a single string that contains all but the
> last line of the file, which, in my case was > 2GB. I'm guessing there was a memory error that simply wasn't being
> reported.


Command #2
- Goal: remove all instances of a Windows style CR followed by a Record Separator (these appear at the end of true
records)

- As you can see, this one is far simpler.

- It simply looks for all instances where there is a combination of the CR RS characters (Windows-style Carriage Return
`\r` followed by a Record Separator `\036`)

- replaces them with nothing (there are no replacement characters in between the two `//` marks at the end).

- It does this globally (trailing `g`) for the file.
