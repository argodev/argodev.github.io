# My Blog

I am uncertain that this repository will be of particular interest to anyone - it is simply used to support my personal blog which is, primarily, a place for me to express my thoughts and work them out so I understand them better. Occasionally, someone benefits from reading the content.

This readme is designed to serve two purposes:
1. Remind me how to use the commands relative to the site
2. Provide credit to those whose code/libraries/etc. this site is based on (there's a bunch).

[![Build Status](https://travis-ci.org/argodev/argodev.github.io.svg?branch=master)](https://travis-ci.org/argodev/argodev.github.io)

[Main Site](http://robgillen.com)


## Helpful Links

- [Getting Started with Jekyll](https://scotch.io/tutorials/getting-started-with-jekyll-plus-a-free-bootstrap-3-starter-theme)
- [Jekyll Maps](https://github.com/ayastreb/jekyll-maps)


## License

Open sourced under the [MIT license](LICENSE.md).



## Publication Management

This is a little more confusing than it should be, and I regularly forget what I need to do. Here are the steps.

1. Maintain the bibliography at https://zotero.org. I am specifically using a public group named `argodev_pubs` and a collection named `mypubs`. This becomes the _authoritative source_ for the bibliography list.
1. Download/setup [zot_bib_web](https://github.com/davidswelt/zot_bib_web)
1. Run `./zot.py --group 2586018 H7WVKG2P` to generate the `html` content (`zotero-bib.html`)
1. Copy/paste the entire `<div class="full-bib-section" />` div from the generated file and replace the div by the same name in `_includes/mypubs.html`
1. Search for instances of `title = {{` and insert a space between the two `{{`
1. Search for instances of `series = {{` and insert a space between the two `{{`

