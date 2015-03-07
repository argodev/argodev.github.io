Today started out with the keynote for the conference and it was certainly not disappointing. The following is
basically a brain dump of the information presented along with some commentary.

Dr. Donald Ferguson (previously a "Fellow" at IBM) opened the conference by explaining talking a little bit about why
he left IBM to join MSFT and explaining some of the MSFT vision for workflow and process modeling. Some interesting
points from his portion of the talk:

* Tools too often tend to speak in infrastructure/technical terms without the proper level of abstraction... this is a
trend that needs to change (i.e. we as technicians need to adapt both ourselves and the tools we expose to end users to
speak a language that they understand).

* Postulated that all organizations exercise at least some level of model-driven development. His position is that even
if you don't have a formal process, you likely have informal processes (i.e. white-boarding)

* Need to automate as much as possible.

* Automation is *not* specifically a threat to people, it is more that it frees them to focus on higher-value work

* Discussed the Enterprise Service Bus which, ideally, organizations will have already deployed.

* Discussed the Internet service bus - which, is a ESB focused on the web as a unit. This is a service that will be
offered/hosted by MSFT

* The goal is to make it simpler for other services/companies/vendors/etc. to connect to this "web of services" (in
contrast to the current perception of the "web of pages")

Robert Wahbe (Corporate VP, MSFT) got up and began giving a pretty interesting talk on the MSFT stack that supports
SOA/BPM as we know it today.  Some general points from his section of the discussion:

* We (as an industry) are looking at new application styles
  * We need to think more about cross-boundary (i.e. firewall) rather than only within the firewall
  * We need to think about federation, rather than domain-specific
  * We need to think about Services rather than objects
* We face a number of challenges...
  * this new model of development forces the integration of business and IT (a problem that should really be addressed
  currently, but this new approach will force it
  * Model-driven development will require improvements and structure ion your software development lifecycle
  * Increasingly need to deal with heterogeneous platforms
  * all of this, while retaining (or creating) flexibility and adaptability
* The MSFT Approach
  * Current product stack - BTS, .NET, VS, Office, SQL, SC, Dynamics
  * Good support for services (WCF, BTS)
  * Gave a demo of a collaborative project of Accenture, Avanade, IDS Scheer, and Microsoft... some pretty interesting
  functionality but not yet fully baked.
  * There is guidance on ESB available at <http://www.codeplex.com/esb>
* General...
  * Favorite Quote: "You gave me exactly what I asked for, but not what I wanted" - common symptom of the disconnect
  b/t business personnel and development staff
  * the services and work we write needs to be reusable.
  * The documentation of the business process is as important as the process itself

The next wave... this is where things got really interesting.

MSFT has the goal of making it *all* model driven. They announced a platform code-named "Oslo" which is a collection
of existing products lines (but future versions) (BTS 6, BizTalk Services 1, VS 10, System Center, .NET Framework 4)
as a "new way to build applications".

This platform includes a new, generic modeling tool that is available across all disciplines (non domain specific).
This tool allows for everyone in the application chain to perform their modeling in the same tool, link the models
together, and also provide a repository for those models. They also indicated that the universal tool was not the
exclusive tool for these models, but rather you could use domain-specific tools, store them in the repository, and
then use this tool to link things together and view the "big picture". What was particularly interesting was the
notion of being able to link everything from the initial requirements modeling, through to system architecture to
design, to coding, through deployment and eventually to monitoring and maintenance all within the same tool... the
ability to link a specific performance problem or improvement directly back to the requirement(s) that caused it is
very interesting.

They then spent some additional time discussing the ISB... specifically on the features that allow you to control
which services are hosted in the cloud vs. those that are hosted locally to your enterprise... It will be interesting
to see how this plays out in the long term... meaning, the idea is interesting, but it requires (at least from my
current understanding) you to "trust" MSFT to host and maintain the service... which then begs questions relative to
security, reliability, etc. of the platform and, of course, if you are running a business based on these, the SLAs in
place and how one deals with a breech or service outage.

Interesting links so far:

* <http://www.codeplex.com/esb>
* <http://k2.net/>
* <http://www.microsoft.com/biztalk/solutions/bpm/bpapartners.mspx>
* <http://www.biztalk.net/>
* <http://www.skelta.com/>
* <http://www.ids-scheer.com/index.html>
* <http://www.pnmsoft.com/>