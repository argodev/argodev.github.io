Well, I'm about a week behind writing this post due to travelling around the world a bit on business, but last weekend 
(June 24-25) represented the annual MIIS Users Group meeting on Microsoft's campus in Redmond.  I'm not sure what the 
official numbers were, but it seemed that there was a good group of users from around the world present for the two 
days of meetings.  During this time we were able to meet some of the MIIS team members as well as be introduced to 
where the product is going both in the short and longer term.

One feature that we've had a number of customers request, and will soon be supported in MIIS (once they RTM SP1) is 
Ctrl-Alt-Del password *sync* across all connected directories that have enrolled in the password management features 
of the MV.  Password management has long been a misunderstood component of the product as many of the people I speak 
with seem to think that MIIS currently supports the synchronization of passwords which is not *quite* the case.  Let me 
explain...

Up to this point, MIIS has had a password *management* feature which allowed a user to go to a web page and after 
authenticating themselves against one of the connected directories, it would allow them to change their password and 
have that new password pushed down to all of the CDs that were enrolled in password management (some directories may 
support it, but security rules in various corporations prohibit credentials being the same across certain systems).

Password *synchronization* has not been possible using MIIS (unless you used a third-party tool such as PSync) due to 
the fact that in order to truly synchronize the passwords across disparate systems, you must be able to capture the 
new password *prior* to its being encrypted by the CD on which it was changed.  Replicating an encrypted version of the 
password would serve no purpose as the encryption algorithm for each CD is different.  In order to capture password 
changes prior to encryption, you would have to have a bit of code living on each of the places where the password could 
be changed, so you can grab it just before encryption and then pass it to the rest of the CDs.  As MIIS has 
traditionally been a "touchless" system (no code deployed on any of the CDs) this is not possible. 

With MIIS 2003 Service Pack 1, an "agent" will be available that will need to be installed on all domain controllers 
in the environment.  This filter will do exactly what was described above for any password changes *originating from 
Active Directory*.  This means that an user sitting at his/her desk can hit the Ctrl+Alt+Del keys, change their AD 
password, and that new change will automatically (in near real time) be pushed to the CDs.  This is obviously not full 
password sync, but rather more of a one-way-push, but nonetheless, it hits us where most of our customers are feeling 
the most pain is that they want to be able to change their password from their desktop and be able to use the same 
password across all of the systems they have to connect to.

I'll try to write more in the coming days of other things learned and discovered.... it's all pretty interesting.
