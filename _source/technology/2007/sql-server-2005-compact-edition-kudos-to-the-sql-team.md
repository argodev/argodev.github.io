If you track the Microsoft or ASP.NET weblogs you've surely noticed that roughly two weeks ago now Microsoft released
SSCE or [SQL Server 2005 Compact Edition](http://www.microsoft.com/sql/editions/compact/default.mspx). Rather than
simply saying "they released it, go download it because it's cool" I want to openly thank the SQL team for providing
a very interesting product. As luck would have it, I was working on a POC for a customer in the later part of December
into early January, and they actually RTM'd the day prior to my final demo (thanks guys!) and allowed me to provide a
rather interesting demo using an approach very different than I had planned. While I'm on the topic, I'd like to give a
shout-out to [Jim Wilson](http://pluralsight.com/blogs/jimw/archive/2006/06/18/28427.aspx) who helped me diagnose a
rather esoteric problem I was having with the CTP.

The customer I was working for had a data-centric web-based application for which they wanted to provide a desktop
version that could function in an "occasionally connected" fashion (ala smart client). Prior to my involvement, they
had an existing mock-up that utilized .NET 1.1 and MSDE on the desktop and replicated with the central SQL 2000
database. They were having some seemingly insurmountable problems with performance and had asked
[my company](http://www.go-planet.com/) to provide an assessment and prove out some of the ideas we may have.

As I studied the existing code base and problem set, there were numerous issues to address but one that gave me pause
was the model for local data storage and replication with the master database. My initial reaction was to attempt to
dump the whole idea of local data storage and adopt more of a service oriented smart client (SOSC) utilizing methods
such as MSMQ and asynchronous web services and simply use a light-weight caching mechanism for the data that that must
reside on the client. However the further I dug into the application, I became convinced that a data-centric smart
client was the right option and therefore I needed to decide on a data storage mechanism for the local client.

As I started my investigation, I believed I had two main options: SQL Server 2005 Express Edition or possibly an XML
file (I was somewhat hopeful that I could make this latter option work).  While digging I came across some pointers to
the (then RC) SQL Server Everywhere Edition. This was the next iteration of SQL Server for Windows CE but had been
adapted and re-licensed to be used on any desktop application. The more I read, the more I liked it. For my customer,
this database engine could not have been a better fit for the following reasons:

* Lightweight Runtime: one of the problems with both MSDE and SQL Express is that they run as a service and are
always running on the client. Since some of the laptops used by their field staff were already resource constrained,
the notion of adding another service that ran continuously wasn't the best option. SSCE's ability to run in-process
made it a great fit.

* Easy Deployment: With both MSDE and SQL Express, the installation is a bit more complicated than I wanted. My goal
was a full click-once deployment and preferably one that didn't require any special permissions (i.e. for users to be
local administrators). While SQL Express has a click-once compliant boot-strapper (I think there might be one for MSDE
as well) it still required a bit heavier install and admin rights. With SSCE, I can simply reference a handful of DLLs
in my project and deploy them to the /bin directory and I'm good to go… this worked perfectly with the click-once
deployment paradigm

* Plausible Deniability/Obfuscation: this one may seem like a bit of a stretch for some, but it actually was one of my
goals. See, the data being stored locally is of a somewhat classified nature (not a matter of national security, but
not necessarily something you want floating around in the general public). One of the problems with MSDE is that you
almost always have that little SQL Server icon in the task bar letting anyone who may have stolen the laptop know that
a database server is running on that machine. SQL Express does not have that problem, but is still easily discoverable
in the services applet. If you combine the fact that with SSCE the application only has the SQL assemblies in the /bin
folder and doesn't run as a service, you wouldn't know that the database existed on the local machine unless you had
prior knowledge of the specific application or happened to search the user's local settings folder for \*.sdf files.
So, the fact that SSCE is on the machine is significantly harder to discover than the other two db engines. Assuming
that they did find the \*.sdf file, I'm protected by...

* Data Encryption: one of the cool features of SSCE is that the database file (the entire \*.sdf) can be encrypted.
Therefore, if someone did find the file, unless they also had the decryption key, the file would be meaningless. This
is not a feature that is available in either of the other db engines.

* Ease of Replication: both MSDE and SQL Express have support to be subscribers to a DB publishing point. One of the
 key features of SSCE is that it is designed from the ground-up for this task… SSCE in combination with SQL 2005 at the
 master DB level supports HTTP/S endpoints for merge replication which allowed me to add a great deal of value in the
 POC… no longer would the field staff be required to VPN into headquarters to sync with the master data source…
 simply opening the app where they had an active Internet connection was all they needed for replication. It should
 be noted that SQL Express also supports HTTP endpoints, however the configuration is a bit trickier (with SSCE I can
 configure the subscription in client code when the app runs for the first time).

* Replication Speed: Speed of replication was one of the largest issues they were experiencing with their early
prototypes based on MSDE (each sync was averaging 15 minutes) - there were a number of issues with the replication
configuration and general db design, however with some changes to the structure, moving the master db to SQL 2005
and using SSCE on the client, I was able to see replication times averaging around 30 seconds (after the initial sync
in which they received the full copy of the various lookup tables, etc… this initial sync was around 60-75 seconds).
Needless to say, this was a great improvement and very well received.

* Replication Feedback: another "gripe" with the early prototype was that while they were synchronizing, the process
would lock the application and very little feedback was provided to the client (i.e. no way to really know how much
longer the sync operation was going to take nor if it were really doing anything). SSCE has great support for
asynchronous merge replication as well as a managed layer for handling replication status events in managed code
allowing me to provide an intelligent progress bar as well as notification text indicating the current operation
taking place (i.e. "downloading users table") etc.

So, at the end of the day, I want to thank the SQL team for helping me do my job - providing my clients with solutions
to their problems using robust technologies that can be customized to address their business problems.