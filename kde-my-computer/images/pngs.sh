#!/bin/sh 

for file in *.svg
	do inkscape -e `basename $file .svg`.png $file
done
