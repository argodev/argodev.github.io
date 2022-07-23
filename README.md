# Files and Content for https://robgillen.com

This repository contains the files and supporting documents for the [Jekyll](https://jekyllrb.com/)-based blog I have sitting at http://robgillen.com. 


```bash
# Install/configure (only once)
sudo gem install bundler jekyll

# install gems
sudo bundle install

# build/run site locally
bundle exec jekyll serve
```


Docs and info can be found here: 
https://github.com/mmistakes/minimal-mistakes


mymaps.google.com



docker pull jekyll/jekyll


or maybe multipass??
multipass mount . foo:/site

sudo apt install ruby ruby-dev build-essential


with multipass enabled...

# can this be moved to cloud-init?
sudo gem install bundler jekyll
# needs to be done from site root (/site)
bundle


Then, you can develop on the vm using the following

```sh
# connect and port-forward
ssh -L 4000:localhost:4000 ubuntu@myblog.local
cd /site
./serve.sh

# view the site using http://localhost:4000
```



Image Handling

Make thumbnails for images:

# widthxheight... if you only need one (e.g. width of 201px), just specify 
# that one and it will scale accordingly.
mogrify -format gif -path thumbs -thumbnail 201 *.jpg