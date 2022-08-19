#! /bin/sh

# export site_name="my-blog" && export MSYS_NO_PATHCONV=1
# docker run --rm \
#   --volume="$PWD:/srv/jekyll" \
#   -it jekyll/jekyll \
#   sh -c "chown -R jekyll /usr/gem/ && jekyll new $site_name" \
#   && cd $site_name

docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  --publish [::1]:4000:4000 \
  jekyll/jekyll \
  jekyll serve  