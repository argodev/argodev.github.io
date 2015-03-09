This is more a personal reminder than anything else…

In my “day job”, I’m working with an [organization](http://ornl.gov/) wherein we are coaching a group of about 80
developers to view opening Visual Studio as their last viable option when looking to solve a problem. This doesn’t mean
coding is bad (I certainly hope not… if so, I think I’d be out of a job soon), but rather represents a mind-set that
recognizes that we have an enormous collection of functionality/tools already available to us (we are building on top of
MOSS 2007) and we need to fully vet the OOTB functionality prior to deciding we need to “roll our own” anything.
Directly tied to this approach is the theory that using OOTB functionality and/or configuration of such (rather than raw
coding) leads to better long-term maintainability and upgrade-ability, not to mention helping to avoid “hit by a
bus” syndrome.

However, sometimes the “preacher” needs to look inwardly and I found myself doing that this weekend. I was working
on a project for a [non-profit organization I work with](http://kids4truth.com/), and found myself looking at what I had
amassed for solving the problem of site-wide search and was displeased. I immediately reverted to my “code first”
tendencies (something I think every developer is born with) and began (mentally) listing the discrepancies with the
current solution and designing a “right” solution. Thankfully, prior to actually writing any code, I was kicking around
some blog posts and something in one of them (honestly don’t remember what/which) got me thinking of the various
“existing” search engines and the fact that they often provide site-specific, nearly OOTB search dialogs that you can
embed into your site. I kicked a couple of them around, and settled on one (ended up with the [live.com search using the
XML web services API](http://dev.live.com/)), and, rather quickly had a fully-functioning search platform on my site…

The “purist” in me immediately thinks of a couple of reasons why this solution “isn’t as good as what I would have
built” (i.e. less control over the actual search results/order, less “immediacy” to updating the index, etc), but
then my more realistic side kicks in and I realize that I’m not a search engine expert… not even close… [Some]
(http://google.com/) might argue as to whether or not those at [live.com](http://search.live.com/) are either :), but I
can guarantee you that they are more so than I, and that the solution “they delivered” is much more accurate and
flexible than I would have built…

I found myself reminding myself to focus on where I can add value, and to leave the rest to others… that’s the only
way to consistently deliver adaptable solutions in an environment where the surrounding technology is changing so
quickly…