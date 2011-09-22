
all: info openSUSE.tar.gz

info:
	echo "Make sure to have php and GraphicsMagick installed"

openSUSE.tar.gz: openSUSE.d
	tar cvfz openSUSE.tar.gz openSUSE
#	rm -r openSUSE

openSUSE.d: gfxboot.d bootsplash.d kdelibs.d yast.d wallpaper.d

gfxboot.d:
	rm -rf openSUSE/gfxboot
	inkscape -w 800 -e tmp.png gfxboot/startup.svg
	mkdir -p openSUSE/gfxboot/data-boot/
	convert tmp.png openSUSE/gfxboot/data-boot/back.jpg
	inkscape -w 800 -e tmp.png gfxboot/install.svg
	mkdir -p openSUSE/gfxboot/data-install
	convert tmp.png openSUSE/gfxboot/data-install/back.jpg
	inkscape -w 800 -e tmp.png gfxboot/welcome.svg
	convert tmp.png openSUSE/gfxboot/data-install/welcome.jpg
	rm tmp.png

bootsplash.d:
	mkdir -p openSUSE
	rm -rf openSUSE/bootsplash
	rm -rf bs
	mkdir bs
	cp -a bootsplash/bootsplash.php bs
	inkscape -w 180 -e bs/logo.png bootsplash/logo.svg
	inkscape -w 90 -e bs/logov.png bootsplash/logo-verbose.svg
	inkscape -w 1600 -e bs/background.png bootsplash/background.svg
	inkscape -w 1600 -e bs/background-verbose.png bootsplash/background-verbose.svg
	cd bs; php ./bootsplash.php
	mv bs/output openSUSE/bootsplash
	rm -rf bs

kdelibs.d:
	rm -rf openSUSE/kdelibs
	mkdir -p openSUSE/kdelibs
	cp kdelibs/body-background.jpg openSUSE/kdelibs

yast.d:
	rm -rf openSUSE/yast_wizard
	mkdir -p openSUSE
	cp -a yast openSUSE/yast_wizard
	rm -f openSUSE/yast_wizard/*.svg

wallpaper.d:
	rm -rf openSUSE/wallpapers
	mkdir -p openSUSE
	cp -a wallpapers openSUSE/
	cp default-1600x1200.jpg openSUSE/wallpapers/openSUSE121-1600x1200.jpg
	cp default-1920x1200.jpg openSUSE/wallpapers/openSUSE121-1920x1200.jpg
	ln -s openSUSE121-1600x1200.jpg openSUSE/wallpapers/default-1600x1200.jpg
	ln -s openSUSE121-1920x1200.jpg openSUSE/wallpapers/default-1920x1200.jpg

