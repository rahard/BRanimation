#! /bin/sh
# (cc) 2019 Budi Rahardjo (@rahard)

# create GIF animation using ImageMagick

# convert scanned images (JPG) to monochrome and convert them into PNG
echo "converting to monochrome"
for file in scan/*.jpg; do convert -monochrome $file "mono/`basename $file .jpg`.png"; done

# convert monochrome files to transparent
echo "creating transparent images"
for file in mono/*.png; do convert +profile "*" $file -transparent white "transparent/`basename $file`"; done

# merge transparent images with background
echo "merge background with transparent images"
for file in transparent/*.png; \
do convert background.jpg $file -background black -gravity center \
-compose over -composite  "merge/`basename $file`"; done

# finally creating the animation
echo "creating GIT animation"
convert merge/*.png -delay 100 -loop 0 anim.gif
