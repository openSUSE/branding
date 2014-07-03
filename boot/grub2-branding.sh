#!/bin/sh

# expect working directory as argument
work_dir="$1"

[ -d "$1" ] || {
  echo usage grub2-branding.sh WORKING_DIRECTORY
  exit 1
}

cd "$1"

# We have 4 main ratio 4:3 5:4 16:9 16:10
# For each of them we create a bunch of 
# links to cover all resolutions
# source http://en.wikipedia.org/wiki/Computer_display_standard

# To optimize png
# optipng -nb -nc -np -o6 *.png

# R32="480x320 720x480 1280x854 1440x960"
R43="320x240 640x480 768x576 800x600 1024x768 1280x960 1400x1050 1600x1200 2048x1536"
# R53="800x480 1280x768"
R54="1280x1024 2560x2048"
R169="854x480 1280x720 1366x768 1920x1080"
R1610="320x200 1280x800 1440x900 1680x1050 1920x1200 2560x1600"
#R179="2048x1080"
#43
for RES in $R43; do
  ln -s -f default-43.png $RES.png
done

#54
for RES in $R54; do
  ln -s -f default-54.png $RES.png
done

#169
for RES in $R169; do
  ln -s -f default-169.png $RES.png
done

#1610
for RES in $R1610; do
  ln -s -f default-1610.png $RES.png
done

