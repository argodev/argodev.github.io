In a number of the posts I've been writing on the SOA/BPM conference I've referred to the applicability (or lack
thereof) of a given approach to "the problem set" that I'm currently working on. I thought it might be good to
describe what it is that I'm looking for and a little bit as to why.

I'm working at an organization with roughly 4,000 employees that is in the process of "drinking the MSFT Koolaid". We
are deploying nearly every MSFT product and working hard to bring consistency to the platform both from a services
aspect as well as the development paradigm. We are focusing on SAP backend, SQL data store, and SharePoint/Office
Suite front-end.

We are also focusing on bringing a consistent story to the workflow problem, and, by "workflow" I really mean (well,
at least for the purposes of this post) business process. We have business processes in SAP that have workflows behind
them and use various means of interaction to keep it moving (i.e. nag-mails, etc.). We have similar workflows in
SharePoint for document approval processes and the like. We also have a third set of workflows (business processes)
that are either not automated at all, or not in any sort of consistent interface. It is this last set processes that
I'm trying to "fix".

I have a couple of "rules":

1. The interface must live in SharePoint (at least the end-user facing portion)

2. The "workflow" aspects of the system should utilize one of the two existing execution engines we have running (SAP o
r WF in MOSS)

3. The workflow designer should be comfortable for a business analyst to use, and preferably an extension to a tool
they are already using (i.e. Visio add-in).

4. The workflow designer should be able to map actual requirements to the steps in the process (where applicable) and
serve as a documentation source of sorts.

5. The process execution system must provide a webparts (or at least the ability to expose the data as webparts) for
the following scenarios:
   1. Overall health of the system
   2. Current user's workflows currently in action
   3. Visual representation of a given workflow process
   4. Analysis relative to the execution stats for each workflow instance and type
      1. i.e. X step of workflow Y is over the planned duration without having completed. Some indication should exist
      that this process is out of line
      2. i.e. Workflows of type X average Y days with the minimum being Z days and the maximum being T days. (and
      trends over time)

6. There must be a hard link between process definition and process execution. The File | Print approach is not
sufficient

7. The system should be standards-based. Meaning, I should be able to import/export the workflow definitions (at least
at some level of granularity) to an industry standard such as BPEL or BPMN in order to be able to share or compare
that process with other organizations.

8. The system should be able to provide governance over the models.

9. In all aspects possible, the system should provide a consistent story WRT the development paradigm we have selected
(MSFT .NET, ASP.NET, Windows Workflow, SharePoint, etc.).

Reality...

1. I'm not exactly certain I'm ready to back down on any of the items above, however I'm coming to the conclusion that
there may be a need for a "third" execution engine - meaning, all of the vendors that I saw that had platforms that
did what I wanted, either used their own custom execution engine or hosted their own instance of WF separate from MOSS.
Even MSFT pushed BizTalk as the "main" process execution engine for *serious* workflows.

2. If reality point #1 is in fact true, the process execution platform should be based on WF allowing the developers
to have a consistent development paradigm.