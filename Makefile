VERSION=12.1
VERSION_NO_DOT=`echo ${VERSION} | sed 's:\.::g'`

all: info openSUSE.tar.gz

info:
	echo "Make sure to have php and GraphicsMagick installed"

openSUSE.tar.gz: openSUSE.d
	tar cvfz openSUSE.tar.gz openSUSE
#	rm -r openSUSE

openSUSE.d: gfxboot.d bootsplash.d kdelibs.d yast.d wallpaper.d ksplashx.d kde-workspace.d kdm.d gnome.d

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
	inkscape -w 200 -e bs/auge_1.png --export-id=Auge_1 -C -j bootsplash/geeko-animation.svg 
	inkscape -w 200 -e bs/auge_2.png --export-id=Auge_2 -C -j bootsplash/geeko-animation.svg
	inkscape -w 200 -e bs/body.png --export-id=Geeko_Body -C -j bootsplash/geeko-animation.svg
	gm composite bs/auge_1.png bs/body.png bs/logo-right.png
	gm composite bs/auge_2.png bs/body.png bs/logo-left.png
	inkscape -w 90 -e bs/logov.png bootsplash/logo-verbose.svg
	mkdir -p bs/output/config
	mkdir -p bs/output/images
	gm convert -comment "id logo delay 1000 deltaprevbg" bs/logo-right.png -comment "id eye1 delay 1000 loop logo deltaprevbg" bs/logo-left.png bs/output/images/logo.mng
	gm convert -colorspace gray -comment "id logov deltabg stop" bs/logov.png bs/output/images/logov.mng
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

ksplashx.d: defaults
	rm -rf openSUSE/ksplashx
	mkdir -p openSUSE/ksplashx
	cp ksplashx/Theme.rc openSUSE/ksplashx/
	cp -a ksplashx/1600x1200 openSUSE/ksplashx/
	inkscape -w 260 -e openSUSE/ksplashx/1600x1200/opensuse-logo.png ksplashx/logo.svg
	mkdir -p openSUSE/ksplashx/1920x1200
	ln -s /etc/bootsplash/themes/openSUSE/images/silent-1600x1200.jpg openSUSE/ksplashx/1600x1200/background.jpg
	ln -s /etc/bootsplash/themes/openSUSE/images/silent-1920x1200.jpg openSUSE/ksplashx/1920x1200/background.jpg
	convert -geometry 300x250 default-1600x1200.jpg openSUSE/ksplashx/Preview.png

kde-workspace.d: defaults
	rm -rf openSUSE/kde-workspace
	mkdir -p openSUSE/kde-workspace
	cp -a kde-workspace/* openSUSE/kde-workspace/
	convert -geometry 400x250 default-1920x1200.jpg openSUSE/kde-workspace/screenshot.jpg

kdm.d: defaults
	rm -rf openSUSE/kdm
	mkdir -p openSUSE/kdm/themes
	cp -a kdm openSUSE/kdm/themes/SUSE
	mv openSUSE/kdm/themes/SUSE/pics openSUSE/kdm/

gnome.d:
	rm -rf openSUSE/gnome
	mkdir -p openSUSE/gnome
	sed "s:@VERSION@:${VERSION}:g" gnome/wallpaper-branding-openSUSE.xml.in > openSUSE/gnome/wallpaper-branding-openSUSE.xml
	sed "s:@VERSION_NO_DOT@:${VERSION_NO_DOT}:g" gnome/openSUSE-default-static.xml.in > openSUSE/gnome/openSUSE-default-static.xml
