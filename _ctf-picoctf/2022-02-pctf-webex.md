---
title: "Web Exploitation"
permalink: /vsstudy/ctf/picoctf/webexploitation
excerpt: "Challenges focused on web site exploitation"
last_modified_at: 2022-08-19
published: True
toc: true
---

## Web Exploitation

### GET aHEAD

This probably goes down as one of those "boy, did you make it harder than it should have been" activities.

You are asked to find the flag hidden at http://mercury.picoctf.net:47967.

After a bit of benign poking around, I assumed that you need to use burp (or similar) to modify the requests, so I fired it up and started looking around. I had expected to find something in the headers taht would give the answer, but no joy. After fighting with this for too long, I broke down and looked at the first hint, which said something like _"maybe you have more than two choices"_. Score one for my lack of creativity. Looking at the page code again, I noticed that one option submitted a `GET` request and the other did a `POST` request.

Great! All I need to do is loop through the valid HTTP verbs, and I'll be set. So, I captured a request in burp, sent it to the Repeater tool, modified the verb, and sent it... did it again for each verb (`GET`, `PUT`, `POST`, `PATCH`, `DELETE`) and, as you might guess... no joy. My creative thinking fails again. Finally, I tried `HEAD` (a guess, based on the title of the challenge) and, wouldn't you guess... bingo.

I then stepped back to `curl` to see if I could have done it there, and ended up with this one-liner:

```bash
# -I (or --head) fetches the HTTP headers only. --> this is the same as sending a HEAD verb
$ curl http://mercury.picoctf.net:47967 -I     
HTTP/1.1 200 OK
flag: picoCTF{redacted_value}
Content-type: text/html; charset=UTF-8
```

### Cookies

Need to try to figure out the "best" cookie from http://mercury.picoctf.net:27177

So, the purpose of this challenge is really to ensure you know how to use Burp Suite's Intruder tool, or something similar. After poking around a bit with valid cookie names, you will notice that upon finding a valid cookie, the user is directed to http://mercury.picoctf.net:27177/check with a cookie value of `name=,some_int>`. The value of `<some_int>` changes based on the cookie name, and appears to be a lookup value of some sort. 

If you configure Intruder to use a sequential numerical payload that goes from say, `1` to `50` in steps of `1` and then run the attack, you'll see that the length property of the response for `18` is different than the rest. Inspecting the returned html will show you the key.

!!! hint
    A helpful link found while working on this challenge is https://github.com/swisskyrepo/PayloadsAllTheThings which provides word lists and various payloads for different situations

