#!/usr/bin/php
<?php
//depends on graphicsmagic and rsvg

$distro = "openSUSE 11.0";
$themename = "SuSE";
$themepath = "./bootsplash/$themename";
$imagepath = "/etc/bootsplash/themes/$themename/images";
//resolution, jpeg export quality pairs
$resolutions = array("640x480"=>"95", "800x600"=>"95", "1024x600"=>"95", 
										 "1024x768"=>"92", "1152x768"=>"92", "1152x864"=>"92", 
										 "1280x768"=>"92", "1366x768"=>"92", "1280x800"=>"92", 
										 "1280x854"=>"92", 
										 "1280x960"=>"92", "1280x1024"=>"92", "1400x1050"=>"91",
										 "1440x900"=>"91", "1600x1024"=>"90", "1600x1200"=>"89", 
										 "1680x1050"=>"89", "1920x1200"=>"80", "3200x1200"=>"70");
/*
$resolutions = array("800x600"=>"95");
*/
//create dirs
if (!is_dir($themepath)) {
	//print "removing old theme $themename\n\n";
	//exec("rm -rf ./theme/$themename");
	mkdir ("./bootsplash");
	mkdir ("$themepath");
	mkdir ("$themepath/config");
	mkdir ("$themepath/images");
} 
//create logos
if (!is_dir('./temp')) {
	mkdir ("./temp");
}
$cmd = "inkscape -w 180 -e ./temp/logo.png logo.svg"; //silent logo
exec($cmd);
$cmd = "inkscape -w 90 -e ./temp/logov.png logo.svg"; //verbose logo
exec($cmd);
$cmd = "gm convert -comment \"id logo deltabg stop\" ./temp/logo.png ./temp/logo.png ./temp/logo.mng";
exec($cmd);
$cmd = "gm convert -colorspace gray -comment \"id logov deltabg stop\" ./temp/logov.png ./temp/logov.png ./temp/logov.mng";
exec($cmd);

#exec("/usr/local/bin/convert ./building-blocks/logo.png $themepath/images/logo.mng");
copy("./temp/logo.mng", "$themepath/images/logo.mng");
copy("./temp/logov.mng", "$themepath/images/logov.mng");

while (list($res,$q) = each($resolutions)) {
//scale backgrounds

	print "creating $res resolution images\n";
	$in = "./background.png";
	$inverb = "./background-verbose.png";
	$silent = "$themepath/images/silent-$res.jpg";
	$verbose = "$themepath/images/bootsplash-$res.jpg";
	$cmd = "gm convert $in -geometry $res\! -quality $q -interlace None -colorspace YCbCr ";
	$cmd .= " -sampling-factor 2x2 $silent"; 
	exec($cmd);
	$cmd = "gm convert $inverb -geometry $res\! -quality $q -interlace None -colorspace YCbCr ";
	$cmd .= " -sampling-factor 2x2 $verbose"; 
	#$cmd = "gm convert $in -colorspace gray -geometry $res\! -quality $q -interlace None ";
	#$cmd .= "-colorspace YCbCr -sampling-factor 2x2 $verbose";
	exec($cmd);

//generate config files
	print "Generating config file for $res\n";
	$fp = fopen("$themepath/config/bootsplash-$res.cfg", "w");
	
	fwrite($fp, "# This is a bootsplash configuration file for\n");
	fwrite($fp, "# $distro, resolution $res.\n");
	fwrite($fp, "#\n");
	fwrite($fp, "# See www.bootsplash.org for more information.\n");
	fwrite($fp, "# created by SUSE Image Builder\n");
	fwrite($fp, "#\n");
	fwrite($fp, "version=3\n"); //config file version
	fwrite($fp, "state=1\n"); //picture is diplayed
	fwrite($fp, "progress_enable=0\n"); //no progress
	fwrite($fp, "overpaintok=1\n"); //no clue what this is
	fwrite($fp, "\n\n");
	//colors
	fwrite($fp, "fgcolor=7\n");
	fwrite($fp, "bgcolor=0\n\n");
	//text window frame
	ereg("([0-9]+)x([0-9]+)", $res, $dimensions);
	$x = $dimensions[1];
	$y = $dimensions[2];
	$tx = 20;
	$ty = 60;
	$tw = $x - $tx - 10;
	$th = $y - $ty;
	fwrite($fp, "tx=$tx\n");
	fwrite($fp, "ty=$ty\n");
	fwrite($fp, "tw=$tw\n");
	fwrite($fp, "th=$th\n");
	//background
	fwrite($fp, "\n\njpeg=$imagepath/bootsplash-$res.jpg\n");
	fwrite($fp, "silentjpeg=$imagepath/silent-$res.jpg\n");
	fwrite($fp, "\n\n");
	$lx = round($x/2); 
	$ly = round($y/2); 
	fwrite($fp, "mnganim logo $imagepath/logo.mng initframe logo silent center $lx $ly\n");
	
	//overlay title (verbose)
	$vlx = 0;
	$vly = 0;
	fwrite($fp, "mnganim logov $imagepath/logov.mng initframe logov origin 0 $vlx $vly\n");
	
	//animation triggers
	fwrite($fp, "trigger \"isdown\" quit\n");
	fwrite($fp, "trigger \"rlreached 5\" toverbose\n");
	fwrite($fp, "trigger \"rlchange 0\" tosilent\n");
	fwrite($fp, "trigger \"rlchange 6\" tosilent\n");

	$verticalpcnt = 0.8;
	$width = 180; //width of the progress bar
	$voffset = 30; //vertical offset from the title (defined by verticalpcnt above)
	$x1 = $lx - round($width/2) - 4;
	$x2 = $x1 + $width;
	$y1 = round($verticalpcnt*$y);
	$y2 = $y1+1; //let's try a 2 pixel line
	fwrite($fp, "\n\n");
	fwrite($fp, "progress_enable=1\n"); //enable progress
	fwrite($fp, "box silent noover $x1 $y1 $x2 $y2 #ffffff10\n"); //progress background
	$wl = "box silent inter " . $x1 . " " . ($y1 - 1) . " " . $x1 . " " . ($y1 + 1) . " #ffffff80\n";
	fwrite($fp, $wl); //starting point ...
	$wl = "box silent " . $x1 . " " . ($y1 - 1) . " " . $x2 . " " . ($y2 + 1) . " #ffffff80\n";
	fwrite($fp, $wl); //..iterated to this

	fclose($fp);
}

?>
