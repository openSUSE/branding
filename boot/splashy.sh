#!/bin/sh
logosvg="./logo.svg"
logopng="./temp/logo.png"
background="./background.png"
temp="./temp/temp.png"
splashy="./splashy/background.png"
splashyg="./splashy/backgroundg.png"

inkscape -z -w 180 -e $logopng $logosvg
gm convert -geometry 1024x768\! $background $temp
gm composite $logopng -compose Over -gravity center $temp $splashy
gm composite $logopng -compose Over -colorspace gray -gravity center $temp $splashyg
