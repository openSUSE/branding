#!/bin/sh

set -e

#depends on graphicsmagic and rsvg

which gm > /dev/null 2>&1
if test $? -ne 0; then
  echo "Please install GraphicsMagick."
  exit 1
fi

which inkscape > /dev/null 2>&1
if test $? -ne 0; then
  echo "Please install inkscape."
  exit 1
fi

version=$1
shift

distro="openSUSE ${version}";
themename="openSUSE";
themepath="output";
imagepath="/etc/bootsplash/themes/$themename/images";

x=$1
shift
y=$1
shift
q=$1
shift

ratio=$(perl -e "use POSIX; print floor($x*100./$y+0.5);")
type=169
if test "$ratio" -lt 162; then
	type=1610
fi
if test "$ratio" -lt 135; then
	type=43
fi
if test "$ratio" -lt 128; then
	type=54
fi

# scale backgrounds

res="$x"x$y;
echo "creating $res resolution images";
silent="$themepath/images/silent-$res.jpg";
verbose="$themepath/images/bootsplash-$res.jpg";
inkscape --export-id=Gradient -e tmp.png -w $x ../bootsplash/silent-$type.svg
cmd="gm convert tmp.png -geometry $res! -quality $q -interlace None -colorspace YCbCr ";
cmd="$cmd -sampling-factor 2x2 $silent"; 
$cmd
inkscape --export-id=Gradient -e tmp.png -w $x ../bootsplash/verbose-$type.svg
cmd="gm convert tmp.png -geometry $res! -quality $q -interlace None -colorspace YCbCr ";
cmd="$cmd -sampling-factor 2x2 $verbose"; 
$cmd
rm tmp.png

# generate config files
echo "Generating config file for $res";

cfgfile=$themepath/config/bootsplash-$res.cfg;
cat > $cfgfile <<EOF
# This is a bootsplash configuration file for
# $distro, resolution $res.
#
# See www.bootsplash.org for more information.
# created by SUSE Image Builder
#
# config file version
version=3 

# picture is diplayed
state=1 

# no progress
progress_enable=0 

# no clue what this is
overpaintok=1

# colors
fgcolor=7
bgcolor=0


#text window frame
EOF

tx=20;
ty=60;
tw=$(echo $x-$tx-10 |bc)
th=$(echo $y-$ty | bc)

iw=$(inkscape -W --query-id=Gradient ../background-$type.svg)
ih=$(inkscape -H --query-id=Gradient ../background-$type.svg)
olw=$(inkscape -W --query-id=Logo ../background-$type.svg)
olh=$(inkscape -H --query-id=Logo ../background-$type.svg)
lp=$(inkscape -X --query-id=Logo ../background-$type.svg)
dx=$(perl -e "use POSIX; print floor($iw-$olw-$lp+0.5);")
lp=$(inkscape -Y --query-id=Logo ../background-$type.svg)
dy=$(perl -e "use POSIX; print floor($ih-$olh-$lp+0.5);")
echo "I $type $iw $ih $olw $olh $dx $dy"
lw=$(perl -e "use POSIX; print floor($x*$olw/$iw+0.5);")
lh=$(perl -e "use POSIX; print floor($lw*$olh/$olw+0.5);")
lx=$(perl -e "use POSIX; print floor($x*($iw-$olw-$dx)/$iw+0.5);")
ly=$(perl -e "use POSIX; print floor($y-$y*$dy/$ih-$lh+0.5);")

vlx=2;
vly=2;

cat >> $cfgfile <<EOF
tx=$tx
ty=$ty
tw=$tw
th=$th

#background
jpeg=$imagepath/bootsplash-$res.jpg
silentjpeg=$imagepath/silent-$res.jpg

mnganim logo $imagepath/logo.mng initframe logo silent origin 0 $lx $ly scale $lw:320
	
# overlay title (verbose)
mnganim logov $imagepath/logov.mng initframe logov origin 0 $vlx $vly

# animation triggers
trigger "isdown" quit
trigger "rlreached 5" toverbose
trigger "rlchange 0" tosilent
trigger "rlchange 6" tosilent
trigger "coolo" play logo
EOF

exit 0
verticalpcnt=0.8;
voffset=$(perl -e "use POSIX; print floor($lw*113./200+6+0.5);")
x1=$(perl -e "use POSIX; print floor($x*.771+0.5);")
x2=$(perl -e "use POSIX; print floor($x*.917+0.5);")
y1=$(echo $ly+$voffset | bc);
y2=$[$y1+1]; # let's try a 2 pixel line

echo "progress_enable=0" >> $cfgfile
echo "box silent noover $x1 $y1 $x2 $y2 #ffffff10" >> $cfgfile
y1_minus=$[$y1-1]
y1_plus=$[$y1+1]
echo "box silent inter $x1 $y1_minus $x1 $y1_plus #ffffff80" >> $cfgfile
y1_plusplus=$[y1+2]
echo "box silent $x1 $y1_minus $x2 $y1_plusplus #ffffff80" >> $cfgfile

