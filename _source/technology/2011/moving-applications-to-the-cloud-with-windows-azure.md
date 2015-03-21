I just finished reading a book from the Microsoft Patterns & Practices group called _Moving Applications to the Cloud
on the Microsoft Windows Azure Platform_. I’ve had the book for a few months, and my when I first received it, I read
the first chapter or two, decided it wasn’t worth the read, and set it aside.

Lately, however, I picked it up again – finished the book, and am glad I did. Don’t get be wrong, it didn’t
magically morph into a superb spectacle of literary greatness, but I did find that as I read further, the authors
moved further from the very basics of the Windows Azure platform and the content became increasingly interesting.

If you are new (or relatively so) to the Windows Azure platform and contemplating the moving of existing applications
to the cloud, this is a worthwhile discussion of a fictitious scenario that did just that. The scenario is slightly on
the cheesy side, but realistic enough to help you think through issues you may be facing in your business.

If you are well experienced with the platform, you will likely find this a bit dry – especially the first portions.
You’ll also likely be distracted or bothered by the not-so-covert marketing that takes place. That said, the book
covers some more complex topics such as multiple tasks/threads sharing the same physical worker role, various
optimization topics, and more. In the end, I’m glad I read it and feel that I learned some things from the book.

My last thought has nothing to do specifically with the book, but rather a growing frustration of mine with the
Windows Azure platform – the design of the table storage platform. Upon reading books such as this I’m reminded (they
stress it *many* times) how important your partition key/row key strategy is, and how literally hosed you are if you
get it wrong. This compares with my recent experiences with Amazon’s SimpleDB product, and the delta couldn’t be more
striking. Both platforms solve essentially the same problem, but in the case of SDB, it is effortless (at least by
comparison). I don’t have to think of partition keys, or be overly concerned with how the underlying storage platform
works… I just put data in it. Additionally, *every* column is indexed and performs reasonably under queries. I can’t
shake the feeling that the Azure team is missing it here – there has to be a way to get a well-designed, horizontally
scaling table structure without placing such a design burden on the users.