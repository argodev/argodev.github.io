Those of you who interact with and develop XML web services on a regular basis are probably very familiar with this
tool or have other tools that you have purchased/developed to provide similar functionality, but I came across the
Web Service Studio
<http://www.gotdotnet.com/Community/UserSamples/Details.aspx?SampleGuid=65a1d4ea-0f7a-41bd-8494-e916ebc4159c> last
night while working on a little web service project and I think it is great… It is straight-forward in its operation,
and doesn’t have a lot of “jazz” to the UI, but it does what it is designed to do… which is providing you with a means
of interacting with Xml web services in an ad hoc fashion.  I used it primarily as a testing tool, to validate that the
web services I was creating worked as they should.  There are many other tools that one could use for performing such
a validation… the built-in test page (only works on the local machine), building a custom client such as a winform app
(this works, but requires a custom build for each web service which is hardly efficient), using a tool such as InfoPath
to quickly build a test form (again, very effective, but requires a new form for each web service).  Web Service Studio
allows me to simply point to a url after which it will read the WSDL, enumerate the methods available to me, generate
the proxy, and let me test/probe each request right there… better yet, it allows me to see the raw XML request being
sent back and forth for each “post” so I can see what the request/response needs to look like for
non-webservice-friendly (i.e. you have to hand-craft the XML) SOAP clients.  Anyway, if you are working with Xml Web
Services on a regular basis and need a simple (and free) testing tool, this tool is definitely worth looking at.