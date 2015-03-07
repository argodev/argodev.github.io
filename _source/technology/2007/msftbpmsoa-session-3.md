The third session I attended was a lunch session sponsored by K2 (<http://www.k2.com>). I was looking forward to this
presentation as I've heard quite a bit about K2, and they've been doing workflow in SharePoint long before MSFT was.

During this session, they focused on their "Black Perl" product which is the current release. Based on the demo, a
quick summary of the product is as follows:

* Middleware platform that provides workflow and reporting based on the concept of "business entities"

* They have a concept of a "SmartObject" which is mechanism for creating, what I would call a composite object/view
of a singe entity within the organization regardless of the data source. This means, I could create a smartobject
which represents an "employee", for which some of its attributes/values are derived directly from SAP, others from AD,
and maybe still others in a custom built SQL DB. This object abstracts for the user all of the complexities of
interacting with the data sources on the backend. In the demo, the showed creating a smart object for which the data
resided in SAP and then exposed that "entity" in a number of different places (SSRS report, workflow, etc.).

All in all, the demo was pretty interesting and there is some applicability to the problem set I'm currently working
with, but I had a hard time imagining a non-developer using their "non-developer" focused tools. I'm certain that it
would come with time, but seemed like a higher barrier to entry than I was looking for.

That being said, as mentioned before, their demo focused specifically on the Black Perl product and, having spent
some more time on their web site since, there are clearly other products/updates to existing products in the works
that might make the entire platform much more of a "fit" for the scenario we are trying to fix.

<img alt='K2 Designer' src='/assets/images/k2designer.png' class='blogimage img-responsive'>