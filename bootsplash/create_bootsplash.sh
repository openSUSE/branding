#!/bin/sh

#depends on graphicsmagic and rsvg

version=$1
shift

distro="openSUSE ${version}";
themename="openSUSE";
themepath="output";
imagepath="/etc/bootsplash/themes/$themename/images";

mkdir -p $themepath/config
mkdir -p $themepath/images

gm convert -comment "id logo deltabg stop" logo.png logo.png $themepath/images/logo.mng
gm convert -colorspace gray -comment "id logov deltabg stop" logov.png logov.png $themepath/images/logov.mng

x=$1
shift
y=$1
shift
q=$1
shift
type=$1
shift

# scale backgrounds

res="$x"x$y;
echo "creating $res resolution images";
silent="$themepath/images/silent-$res.jpg";
verbose="$themepath/images/bootsplash-$res.jpg";
inkscape -e tmp.png -w $x ../bootsplash/silent$type.svg
cmd="gm convert tmp.png -geometry $res! -quality $q -interlace None -colorspace YCbCr ";
cmd="$cmd -sampling-factor 2x2 $silent"; 
$cmd
inkscape -e tmp.png -w $x ../bootsplash/verbose$type.svg
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

lx=$(echo $x/2 | bc); 
ly=$(echo $y/2-20 | bc); 

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

mnganim logo $imagepath/logo.mng initframe logo silent center $lx $ly
	
# overlay title (verbose)
mnganim logov $imagepath/logov.mng initframe logov origin 0 $vlx $vly

# animation triggers
trigger "isdown" quit
trigger "rlreached 5" toverbose
trigger "rlchange 0" tosilent
trigger "rlchange 6" tosilent
EOF

verticalpcnt=0.8;
width=160; # width of the progress bar
voffset=80; # vertical offset from the title (defined by verticalpcnt above)
x1=$(echo "$lx-$width/2 - 4" | bc);
x2=$[$x1+$width]
y1=$(echo $ly+$voffset | bc);
y2=$[$y1+1]; # let's try a 2 pixel line

echo "progress_enable=1" >> $cfgfile
echo "box silent noover $x1 $y1 $x2 $y2 #ffffff10" >> $cfgfile
y1_minus=$[$y1-1]
y1_plus=$[$y1+1]
echo "box silent inter $x1 $y1_minus $x1 $y1_plus #ffffff80" >> $cfgfile
echo "box silent $x1 $x1 $y1_minus $x1 $y1_plus #ffffff80" >> $cfgfile

