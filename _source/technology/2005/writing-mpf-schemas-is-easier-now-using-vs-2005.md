I know many people do not take the time to include schemas in their MPF named procedures, but I am a big fan.  Here at
eQuest, we use these in-line schemas for all sorts of things ranging from auto-generating CHM files to auto-generating
strongly-typed C# and XML Web Service wrappers. The problem is, these are a *pain* to write.  I hate writing them, and
even worse, they are hard to get accurate.  It is very easy to miss a step, or mis-state a requirement, etc.  It is
very easy to duplicate a node, or forget to include a node, etc.

Yesterday I was faced with the need to write a schema for a named procedure I had just written for a client.  Because
of some rather unique lab environment issues, I elected to write them directly on my machine, where, I just happened to
have VS.NET 2005 Beta 2 installed.

What I found was that VS.NET 2005 includes two features that make the editing of XML and the associated schemas much
easier. The first is intellisense.  This is not a surprise, and I had heard that VS 2005 included better support for a
wider range of XML namespaces, but I suppose I didn’t really think about it until it “just started working”. The
following is an example of in-line schema intellisense…

<img alt='Schema 02' src='/assets/images/schema02.png' class='blogimage img-responsive'>

The second feature, and probably cooler feature (from my perspective) is the ability for VS to validate the schema nodes
I’m creating relative to the schema nodes I’ve already created.  For example, if I add an `<element />` node for a type
for which I have not yet defined an `<ElementType/>`, I will get the appropriate squiggly lines indicating a problem.
The same is true for `<attribute/>` and `<AttributeType/>` tags. Also, if I have duplicate `<element/>` nodes it will
complain. Where this helps me, is that it is often easier (for me, in my limited view of this) to begin by creating the
`<ElementType />` node for `type=executeData` and then populating all of the appropriate `<element/>` nodes.  Then, I
can use the validation features of VS to let me know when I have finished implementing the required `<ElementType/>`
nodes. The following is a screen shot of this validation:

<img alt='Schema 01' src='/assets/images/schema01.png' class='blogimage img-responsive'>

These are great new features and I’m excited to see how this will speed my development moving forward

(note: yes, I’m aware that XMLSpy does this now, but I’ve simply not been able to get myself into the habit of having
two “heavier” apps running to support my coding… I end up using VS for all of it… and I’m also aware that XMLSpy has an
add-in for VS… but it changes the XML fonts and styles and that bugs me… oh well…)