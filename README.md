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

# Lanyon

Lanyon is an unassuming [Jekyll](http://jekyllrb.com) theme that places content first by tucking away navigation in a hidden drawer. It's based on [Poole](http://getpoole.com), the Jekyll butler.

![Lanyon](https://f.cloud.github.com/assets/98681/1825266/be03f014-71b0-11e3-9539-876e61530e24.png)
![Lanyon with open sidebar](https://f.cloud.github.com/assets/98681/1825267/be04a914-71b0-11e3-966f-8afe9894c729.png)


## Contents

- [Usage](#usage)
- [Options](#options)
  - [Sidebar menu](#sidebar-menu)
  - [Themes](#themes)
  - [Reverse layout](#reverse-layout)
- [Development](#development)
- [Author](#author)
- [License](#license)


## Usage

Lanyon is a theme built on top of [Poole](https://github.com/poole/poole), which provides a fully furnished Jekyll setup—just download and start the Jekyll server. See [the Poole usage guidelines](https://github.com/poole/poole#usage) for how to install and use Jekyll.


## Options

Lanyon includes some customizable options, typically applied via classes on the `<body>` element.


### Sidebar menu

Create a list of nav links in the sidebar by assigning each Jekyll page the correct layout in the page's [front-matter](http://jekyllrb.com/docs/frontmatter/).

```
---
layout: page
title: About
---
```

**Why require a specific layout?** Jekyll will return *all* pages, including the `atom.xml`, and with an alphabetical sort order. To ensure the first link is *Home*, we exclude the `index.html` page from this list by specifying the `page` layout.







## Author

**Rob Gillen**
- <https://github.com/argodev>
- <https://twitter.com/argodev>


## License

Open sourced under the [MIT license](LICENSE.md).

<3
