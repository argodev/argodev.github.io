---
title: "PortSwigger Academy: Access Control Vulnerabilities"
permalink: /vsstudy/ctf/portswigger/accesscontrol
excerpt: "PortSwigger Academy is a collection of training materials (reading & videos) combined with hands-on-labs designed to help you learn how to 'secure the web one step at a time'. It covers a number of the most common vulnerabilities, helping you understand them, understand how to exploit them, and how they can be prevented. Best of all, they are all free. The tools *are* designed to work with/be supported by PortSwigger's flagship product, Burp Suite Professional, but you can utilize any number of other tools (curl/browsers/ZAP/etc). At the time I worked through these, I did not have access to a professional license, so I used the Burp Suite Community edition (free). Below are my notes written as I worked through the various challenges."
last_modified_at: 2022-06-27
published: True
toc: true
---

## :material-gauge-empty: Unprotected admin functionality

!!! question
    This lab has an unprotected admin panel.

    Solve the lab by deleting the user `carlos`.

This was pretty simple, though it took me a bit to remember that `/robots.txt` can be your friend when looking for "hidden" directory paths. Once I remembered this, I navigated to `/administrator-panel` (which was unprotected) and successfully deleted the user.

## :material-gauge-empty: Unprotected admin functionality with unpredictable URL

!!! question
    This lab has an unprotected admin panel. It's located at an unpredictable location, but the location is disclosed somewhere in the application.

    Solve the lab by accessing the admin panel, and using it to delete the user `carlos`.

The normal guesses didn't work, so I started looking through the raw HTML within burpsuite. Eventually, I stumbled across this bit of JavaScript:

```javascript
var isAdmin = false;
if (isAdmin) {
   var topLinksTag = document.getElementsByClassName("top-links")[0];
   var adminPanelTag = document.createElement('a');
   adminPanelTag.setAttribute('href', '/admin-gw0pr8');
   adminPanelTag.innerText = 'Admin panel';
   topLinksTag.append(adminPanelTag);
   var pTag = document.createElement('p');
   pTag.innerText = '|';
   topLinksTag.appendChild(pTag);
}
```

This made it clear that simply going to `/admin-gw0pr8` was the key and I was able to delete the user.

## :material-gauge-empty: User role controlled by request parameter

!!! question
    This lab has an admin panel at `/admin`, which identifies administrators using a forgeable cookie.

    Solve the lab by accessing the admin panel and using it to delete the user `carlos`.

    You can log in to your own account using the following credentials: `wiener:peter`

I first visited the site and logged in with "my" credentials and then attempted to visit the `/admin` page. After receiving an error, I looked at the response data in burpsuite. I immediately saw a cookie that looked like the following: `Cookie: Admin=false; session=D8CRqtEqMaPm0lhHMAVEcW452XcJq0Cd`. I sent the request to the "Repeater" tool and edited the cookie to say `Admin=true;`. I then used the "request in browser/original session" tool, and the page rendered properly and I deleted the user. 

__UPDATE__ Actually, the above *didn't* solve it. I did successfully get to the admin page, but the request to delete the user was denied because the cookie had been re-written. I probaby could have solved this via a re-write rule, but ended up just editing the `GET` request to `/admin/delete?username=carlos` and submitting it via the repeater tool.

