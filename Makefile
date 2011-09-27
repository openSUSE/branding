VERSION=12.1
VERSION_NO_DOT=`echo ${VERSION} | sed 's:\.::g'`

all: info openSUSE.tar.gz

info:
	echo "Make sure to have php and GraphicsMagick installed"

openSUSE.tar.gz: openSUSE.d
	tar cvfz openSUSE.tar.gz openSUSE
#	rm -r openSUSE

openSUSE.d: gfxboot.d bootsplash.d kdelibs.d yast.d wallpaper.d

gfxboot.d: defaults
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
	cp -a bootsplash/create_bootsplash.sh bs
	inkscape -e bs/auge_1.png --export-id=Auge_1 -C -j bootsplash/geeko-animation.svg 
	inkscape -e bs/auge_2.png --export-id=Auge_2 -C -j bootsplash/geeko-animation.svg
	inkscape -e bs/body.png --export-id=Geeko_Body -C -j bootsplash/geeko-animation.svg
	inkscape -w 180 -e bs/logo.png bootsplash/logo.svg
	inkscape -w 90 -e bs/logov.png bootsplash/logo-verbose.svg
	cd bs ;\
	  sh create_bootsplash.sh ${VERSION} 640 480 95 43 ;\
	  sh create_bootsplash.sh ${VERSION} 800 600 95 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1024 600 94 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1024 768 94 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1152 768 94 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1152 864 93 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1280 768 93 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1366 768 93 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1280 800 93 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1280 854 93 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1280 960 92 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1280 1024 92 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1400 1050 91 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1440 900 91 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1600 1024 90 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1600 1200 89 43 ;\
	  sh create_bootsplash.sh ${VERSION} 1600 900 90 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1920 1080 90 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1680 1050 89 169 ;\
	  sh create_bootsplash.sh ${VERSION} 1920 1200 80 169 ;\
	  sh create_bootsplash.sh ${VERSION} 3200 1200 70 169

	mv bs/output openSUSE/bootsplash
	rm -rf bs

kdelibs.d: defaults
	rm -rf openSUSE/kdelibs
	mkdir -p openSUSE/kdelibs
	cp kdelibs/body-background.jpg openSUSE/kdelibs

yast.d:
	rm -rf openSUSE/yast_wizard
	mkdir -p openSUSE
	cp -a yast openSUSE/yast_wizard
	rm -f openSUSE/yast_wizard/*.svg

wallpaper.d: defaults
	rm -rf openSUSE/wallpapers
	mkdir -p openSUSE/wallpapers
	cp wallpapers/default-1600x1200.jpg.desktop openSUSE/wallpapers
	cp wallpapers/default-1920x1200.jpg.desktop openSUSE/wallpapers
	sed "s:@VERSION@:${VERSION}:g;s:@VERSION_NO_DOT@:${VERSION_NO_DOT}:g" wallpapers/openSUSE-1600x1200.jpg.desktop.in > openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1600x1200.jpg.desktop
	sed "s:@VERSION@:${VERSION}:g;s:@VERSION_NO_DOT@:${VERSION_NO_DOT}:g" wallpapers/openSUSE-1920x1200.jpg.desktop.in > openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1200.jpg.desktop
	cp default-1600x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1600x1200.jpg
	cp default-1920x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1200.jpg
	ln -s openSUSE${VERSION_NO_DOT}-1600x1200.jpg openSUSE/wallpapers/default-1600x1200.jpg
	ln -s openSUSE${VERSION_NO_DOT}-1920x1200.jpg openSUSE/wallpapers/default-1920x1200.jpg

defaults:
	inkscape -e default-1600x1200.png -w 1600 background-43.svg
	convert -geometry 1600x1200 default-1600x1200.png default-1600x1200.jpg
	inkscape -e default-1900.png -w 1920 background-169.svg
	convert -geometry 1920x1200 default-1900.png default-1920x1200.jpg
	rm default-1900.png default-1600x1200.png 

