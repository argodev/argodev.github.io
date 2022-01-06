#!/bin/bash
# https://www.cyberciti.biz/tips/howto-linux-creating-a-image-thumbnails-from-shell-prompt.html

# for i in *.jpg; do convert $i -resize 1200x750 ../fulls/$i; done
# for i in *.jpg; do convert $i -resize 360x225 ../thumbs/$i; done
# for i in *.jpg; do convert $i -resize 360x225 -background black -gravity center -extent 360x225 ../thumbs/$i; done


for i in $1/*.jpg
do
    #echo $i
    echo "  - title: "
    echo "    image: https://umdzysetiu80mfh1bz.s3.amazonaws.com/familypictures2021/originals/"${i##*/}
    echo "    thumbnail: https://umdzysetiu80mfh1bz.s3.amazonaws.com/familypictures2021/thumbs/"${i##*/}
    echo "    caption: "

#    djpeg $i | pnmscale -xysize 360 225 | cjpeg -optimize -progressive -quality 75 > ../thumbs/$i;
done

