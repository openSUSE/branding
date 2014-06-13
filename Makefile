NAME=grow
VERSION=13.1
VERSION_NO_DOT=`echo ${VERSION} | sed 's:\.::g'`
THEME=openSUSE

all: info openSUSE.tar.xz

info:
	echo "Make sure to have inkscape, GraphicsMagick and optipng installed"

openSUSE.tar.xz: openSUSE.d
	tar cvfJ openSUSE.tar.xz openSUSE
#	rm -r openSUSE

openSUSE.tar.xz_clean:
	rm -f openSUSE.tar.xz

CLEAN_DEPS+=openSUSE.tar.xz_clean

openSUSE.d: gfxboot.d grub2.d kdelibs.d yast.d wallpaper.d ksplashx.d ksplash-qml.d kdm.d gnome.d susegreeter.d xfce.d plymouth.d
	cp Makefile LICENSE openSUSE

openSUSE.d_clean:
	rm -rf openSUSE/Makefile
	rm -rf openSUSE/LICENSE

CLEAN_DEPS+=openSUSE.d_clean

gfxboot.d: defaults
	inkscape -w 800 -e tmp.png gfxboot/startup.svg
	mkdir -p openSUSE/gfxboot/data-boot/
	cp gfxboot/FifthLeg-Heavy-Cyrillic.otf ~/.fonts
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 tmp.png openSUSE/gfxboot/data-boot/back.jpg
	inkscape -w 800 -e tmp.png gfxboot/install.svg
	mkdir -p openSUSE/gfxboot/data-install
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 tmp.png openSUSE/gfxboot/data-install/back.jpg
	inkscape -w 800 -e tmp.png gfxboot/welcome.svg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 tmp.png openSUSE/gfxboot/data-install/welcome.jpg
	mkdir -p ~/.fonts
	inkscape -D -w 114 -e tmp.png gfxboot/text.svg
	rm ~/.fonts/FifthLeg-Heavy-Cyrillic.otf
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 tmp.png openSUSE/gfxboot/data-install/text.jpg
	rm tmp.png

gfxboot.d_clean:
	rm -rf openSUSE/gfxboot

CLEAN_DEPS+=gfxboot.d_clean

grub2.d:
	mkdir -p openSUSE/grub2/backgrounds
	inkscape -w 1920 -C -e openSUSE/grub2/backgrounds/default-1610.png grub2-1610.svg
	optipng -o4 openSUSE/grub2/backgrounds/default-1610.png
	inkscape -w 1920 -C -e openSUSE/grub2/backgrounds/default-169.png grub2-169.svg	
	optipng -o4 openSUSE/grub2/backgrounds/default-169.png
	inkscape -w 1280 -C -e openSUSE/grub2/backgrounds/default-54.png grub2-54.svg
	optipng -o4 openSUSE/grub2/backgrounds/default-54.png
	inkscape -w 1600 -C -e openSUSE/grub2/backgrounds/default-43.png grub2-43.svg
	optipng -o4 openSUSE/grub2/backgrounds/default-43.png
	cp -a boot/grub2/theme openSUSE/grub2/
	./boot/grub2-branding.sh openSUSE/grub2/backgrounds

grub2.d_clean:
	rm -rf openSUSE/grub2

CLEAN_DEPS+=grub2.d_clean

PLS=openSUSE/plymouth/theme/openSUSE.script

openSUSE/plymouth/theme/openSUSE.script: boot/plymouth/theme/*
	mkdir -p openSUSE/plymouth
	cp -a boot/plymouth/theme openSUSE/plymouth/

PLYMOUTH_DEPS=${PLS}

openSUSE/plymouth/theme/blank-background-1610.png: blank-background-1610.svg ${PLS}
	inkscape -w 1920 -C -e openSUSE/plymouth/theme/blank-background-1610.png blank-background-1610.svg
	optipng -o4 openSUSE/plymouth/theme/blank-background-1610.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/blank-background-1610.png

openSUSE/plymouth/theme/logo-1610.png: background-1610.svg ${PLS}
	inkscape -w 1920 -C -e openSUSE/plymouth/theme/logo-1610.png logo-1610.svg
	optipng -o4 openSUSE/plymouth/theme/logo-1610.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/logo-1610.png

openSUSE/plymouth/theme/blank-background-169.png: blank-background-169.svg ${PLS}
	inkscape -w 1920 -C -e openSUSE/plymouth/theme/blank-background-169.png blank-background-169.svg
	optipng -o4 openSUSE/plymouth/theme/blank-background-169.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/blank-background-169.png

openSUSE/plymouth/theme/logo-169.png: logo-169.svg ${PLS}
	inkscape -w 1920 -C -e openSUSE/plymouth/theme/logo-169.png logo-169.svg
	optipng -o4 openSUSE/plymouth/theme/logo-169.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/logo-169.png

openSUSE/plymouth/theme/blank-background-54.png: blank-background-54.svg ${PLS}
	inkscape -w 1280 -C -e openSUSE/plymouth/theme/blank-background-54.png blank-background-54.svg
	optipng -o4 openSUSE/plymouth/theme/blank-background-54.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/blank-background-54.png

openSUSE/plymouth/theme/logo-54.png: logo-54.svg ${PLS}
	inkscape -w 1280 -C -e openSUSE/plymouth/theme/logo-54.png logo-54.svg
	optipng -o4 openSUSE/plymouth/theme/logo-54.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/logo-54.png

openSUSE/plymouth/theme/blank-background-43.png: blank-background-43.svg ${PLS}
	inkscape -w 1600 -C -e openSUSE/plymouth/theme/blank-background-43.png blank-background-43.svg
	optipng -o4 openSUSE/plymouth/theme/blank-background-43.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/blank-background-43.png

openSUSE/plymouth/theme/logo-43.png: logo-43.svg ${PLS}
	inkscape -w 1600 -C -e openSUSE/plymouth/theme/logo-43.png logo-43.svg
	optipng -o4 openSUSE/plymouth/theme/logo-43.png

PLYMOUTH_DEPS+=openSUSE/plymouth/theme/logo-43.png

plymouth.d: ${PLYMOUTH_DEPS}

plymouth.d_clean:
	rm -rf openSUSE/plymouth

CLEAN_DEPS+=plymouth.d_clean

kdelibs.d: defaults
	mkdir -p openSUSE/kdelibs
	cp kdelibs/body-background.jpg kdelibs/css.diff openSUSE/kdelibs

kdelibs.d_clean:
	rm -rf openSUSE/kdelibs

CLEAN_DEPS+=kdelibs.d_clean

yast.d:
#	create directly the background from the 4:3 root's blank background
	mkdir -p openSUSE/yast_wizard
	cp -a yast/* openSUSE/yast_wizard
	inkscape -w 1600 -C -e openSUSE/yast_wizard/background.png blank-background-43.svg
	rm -f openSUSE/yast_wizard/*.svg

yast.d_clean:
	rm -rf openSUSE/yast_wizard

CLEAN_DEPS+=yast.d_clean

wallpaper.d: defaults
	mkdir -p openSUSE/wallpapers
	cp wallpapers/default-1600x1200.jpg.desktop openSUSE/wallpapers
	cp wallpapers/default-1920x1200.jpg.desktop openSUSE/wallpapers
	cp wallpapers/default-1920x1080.jpg.desktop openSUSE/wallpapers
	mkdir -p openSUSE/wallpapers/openSUSEdefault/contents/images
	sed "s:@VERSION@:${VERSION}:g;s:@VERSION_NO_DOT@:${VERSION_NO_DOT}:g" wallpapers/openSUSE-1600x1200.jpg.desktop.in > openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1600x1200.jpg.desktop
	sed "s:@VERSION@:${VERSION}:g;s:@VERSION_NO_DOT@:${VERSION_NO_DOT}:g" wallpapers/openSUSE-1920x1200.jpg.desktop.in > openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1200.jpg.desktop
	sed "s:@VERSION@:${VERSION}:g;s:@VERSION_NO_DOT@:${VERSION_NO_DOT}:g" wallpapers/openSUSE-1920x1080.jpg.desktop.in > openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1080.jpg.desktop
	ln -sf openSUSE${VERSION_NO_DOT}-1600x1200.jpg openSUSE/wallpapers/default-1600x1200.jpg
	ln -sf openSUSE${VERSION_NO_DOT}-1920x1200.jpg openSUSE/wallpapers/default-1920x1200.jpg
	ln -sf openSUSE${VERSION_NO_DOT}-1920x1080.jpg openSUSE/wallpapers/default-1920x1080.jpg
	cp default-1280x1024.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1280x1024.jpg
	cp default-1600x1200.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1600x1200.jpg
	cp default-1920x1080.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1920x1080.jpg
	cp default-1920x1200.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1920x1200.jpg
	ln -sf openSUSEdefault/contents/images/1920x1080.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1080.jpg
	ln -sf openSUSEdefault/contents/images/1920x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1200.jpg
	ln -sf openSUSEdefault/contents/images/1600x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1600x1200.jpg
	convert -quality 90 -geometry 400x250 default-1920x1200.jpg openSUSE/wallpapers/openSUSEdefault/screenshot.jpg
	cp -p kde-workspace/metadata.desktop openSUSE/wallpapers/openSUSEdefault/metadata.desktop

wallpaper.d_clean:
	rm -rf openSUSE/wallpapers

CLEAN_DEPS+=wallpaper.d_clean

default-1280x1024.jpg: background-54.svg
	inkscape -e default-1280x1024.png -w 1280 background-54.svg
	convert -quality 100 -geometry 1280x1024 default-1280x1024.png default-1280x1024.jpg
	rm default-1280x1024.png

default-1600x1200.jpg: background-43.svg
	inkscape -e default-1600x1200.png -w 1600 background-43.svg
	convert -quality 100 -geometry 1600x1200 default-1600x1200.png default-1600x1200.jpg
	rm default-1600x1200.png

default-1920x1080.jpg: background-169.svg
	inkscape -e default-1920x1080.png -w 1920 background-169.svg
	convert -quality 100 -geometry 1920x1080 default-1920x1080.png default-1920x1080.jpg
	rm default-1920x1080.png

default-1920x1200.jpg: background-1610.svg
	inkscape -e default-1920x1200.png -w 1920 background-1610.svg
	convert -quality 100 -geometry 1920x1200 default-1920x1200.png default-1920x1200.jpg
	rm default-1920x1200.png

# When changing the commands below, also update the commands in gnome_dynamic
defaults: default-1280x1024.jpg default-1600x1200.jpg default-1920x1080.jpg default-1920x1200.jpg

defaults_clean:
	rm -f default-1280x1024.jpg
	rm -f default-1600x1200.jpg
	rm -f default-1920x1080.jpg
	rm -f default-1920x1200.jpg

CLEAN_DEPS+=defaults_clean

ksplashx.d: defaults
	mkdir -p openSUSE/ksplashx
	sed "s:@VERSION@:${VERSION}:g" ksplashx/Theme.rc.in > openSUSE/ksplashx/Theme.rc
	cp -a ksplashx/1920x1200 openSUSE/ksplashx/
	inkscape -w 260 --export-id=Geeko -C -j -e openSUSE/ksplashx/1920x1200/opensuse-logo.png logo.svg
	convert -geometry 300x250 default-1920x1200.jpg openSUSE/ksplashx/Preview.png

ksplashx.d_clean:
	rm -rf openSUSE/ksplashx

CLEAN_DEPS+=ksplashx.d_clean

#This is called openSUSE
kdm.d: defaults
	mkdir -p openSUSE/kdm/themes/openSUSE
	cp -a kdm/* openSUSE/kdm/themes/openSUSE
	cp -r openSUSE/kdm/themes/openSUSE/pics/* openSUSE/kdm/
	rm -rf openSUSE/kdm/themes/openSUSE/pics

kdm.d_clean:
	rm -rf openSUSE/kdm

CLEAN_DEPS+=kdm.d_clean

ksplash-qml.d: 
	mkdir -p openSUSE/ksplash-qml
	sed "s:@VERSION@:${VERSION}:g" ksplash-qml/Theme.rc.in > openSUSE/ksplash-qml/Theme.rc
	cp ksplash-qml/main.qml openSUSE/ksplash-qml/main.qml
	cp ksplash-qml/Preview.png openSUSE/ksplash-qml/Preview.png
	cp -a ksplash-qml/images openSUSE/ksplash-qml/

ksplash-qml.d_clean:
	rm -rf openSUSE/ksplash-qml

CLEAN_DEPS+=ksplash-qml.d_clean

# Create images used for the dynamic wallpaper; note that we do the same as in the 'defaults' target
gnome_dynamic: defaults
	mkdir -p gnome/dynamic
	for file in morning night; do \
		inkscape -z -e gnome/$${file}-1280x1024.png -w 1280 gnome/$${file}54.svg ; \
		convert -quality 100 -geometry 1280x1024 gnome/$${file}-1280x1024.png gnome/dynamic/$${file}-1280x1024.jpg ; \
		inkscape -z -e gnome/$${file}-1600x1200.png -w 1600 gnome/$${file}43.svg ; \
		convert -quality 100 -geometry 1600x1200 gnome/$${file}-1600x1200.png gnome/dynamic/$${file}-1600x1200.jpg ; \
		inkscape -z -e gnome/$${file}-1920x1080.png -w 1920 -h 1080 gnome/$${file}169.svg ; \
		convert -quality 100 -geometry 1920x1080 gnome/$${file}-1920x1080.png gnome/dynamic/$${file}-1920x1080.jpg ; \
		inkscape -z -e gnome/$${file}-1920x1200.png -w 1920 -h 1200 gnome/$${file}1610.svg ; \
		convert -quality 100 -geometry 1920x1200 gnome/$${file}-1920x1200.png gnome/dynamic/$${file}-1920x1200.jpg ; \
		rm gnome/$${file}-1280x1024.png gnome/$${file}-1600x1200.png gnome/$${file}-1920x1200.png gnome/$${file}-1920x1080.png ; \
	done
	cp default-1280x1024.jpg gnome/dynamic/day-1280x1024.jpg
	cp default-1600x1200.jpg gnome/dynamic/day-1600x1200.jpg
	cp default-1920x1080.jpg gnome/dynamic/day-1920x1080.jpg
	cp default-1920x1200.jpg gnome/dynamic/day-1920x1200.jpg
	sed "s:@PATH_TO_IMAGES@:/usr/share/backgrounds/${NAME}:g" gnome/dynamic-wallpaper.xml.in > gnome/dynamic/${NAME}.xml
	sed "s:@PATH_TO_IMAGES@:`pwd`/gnome/dynamic:g" gnome/dynamic-wallpaper.xml.in > gnome/dynamic-wallpaper-localtest.xml
	sed "s:@PATH_TO_IMAGES@:`pwd`/gnome/dynamic:g;s:7200:6:g;s:14400:12:g;s:18000:15:g;s:25200:21:g" gnome/dynamic-wallpaper.xml.in > gnome/dynamic-wallpaper-localtest-fast.xml

gnome_dynamic_clean:
	rm -rf gnome/dynamic

CLEAN_DEPS+=gnome_dynamic_clean

gnome.d: gnome_dynamic
	mkdir -p openSUSE/gnome
	sed "s:@VERSION@:${VERSION}:g;s:@GNOME_STATIC_DYNAMIC@:static:g" gnome/wallpaper-branding-openSUSE.xml.in > openSUSE/gnome/wallpaper-branding-openSUSE.xml
	cp gnome/openSUSE-default-static.xml openSUSE/gnome/openSUSE-default-static.xml
	sed "s:@VERSION@:${VERSION}:g;s:@GNOME_STATIC_DYNAMIC@:dynamic:g" gnome/wallpaper-branding-openSUSE.xml.in > openSUSE/gnome/dynamic-wallpaper-branding-openSUSE.xml
	cp -a gnome/dynamic/ openSUSE/gnome/${NAME}

gnome.d_clean:
	rm -rf openSUSE/gnome

CLEAN_DEPS+=gnome.d_clean

susegreeter.d:
	mkdir -p openSUSE/SUSEgreeter
	inkscape -w 800 -e openSUSE/SUSEgreeter/background.png kde-workspace/SUSEgreeter/background.svg

susegreeter.d_clean:
	rm -rf openSUSE/SUSEgreeter

CLEAN_DEPS+=susegreeter.d_clean

xfce.d:
	mkdir -p openSUSE/xfce
	inkscape -w 350 -e openSUSE/xfce/splash.png xfce/splash.svg
	cp xfce/COPYING openSUSE/xfce/COPYING

xfce.d_clean:
	rm -rf openSUSE/xfce

CLEAN_DEPS+=xfce.d_clean

install: # do not add requires here, this runs from generated openSUSE
	install -D -m 644 kdelibs/body-background.jpg ${DESTDIR}/usr/share/kde4/apps/kdeui/about/body-background.jpg

	install -d ${DESTDIR}/usr/share/wallpapers
	cp -a wallpapers/* ${DESTDIR}/usr/share/wallpapers

	## Install xml files used by GNOME to find default wallpaper
	# Here's the setup we use:
	#  - /usr/share/wallpapers/openSUSE-default.xml is the default background
	#  - /usr/share/wallpapers/openSUSE-default.xml is a symlink (via
	#    update-alternatives) to either:
	#    a) /usr/share/wallpapers/openSUSE-default-static.xml (from
	#        wallpaper-branding-openSUSE)
	#    b) /usr/share/wallpapers/openSUSE-default-dynamic.xml (from
	#        dynamic-wallpaper-branding-openSUSE)
	#  - /usr/share/wallpapers/openSUSE-default-dynamic.xml is a symlink to the
	#    dynamic background (since this XML file moves from a version to another)
	#
	# Static wallpaper
	install -D -m 0644 gnome/wallpaper-branding-openSUSE.xml ${DESTDIR}/usr/share/gnome-background-properties/wallpaper-branding-openSUSE.xml
	install -m 0644 gnome/openSUSE-default-static.xml ${DESTDIR}/usr/share/wallpapers/openSUSE-default-static.xml
	# Dynamic wallpaper
	install -d ${DESTDIR}/usr/share/backgrounds
	if test -z "${NAME}"; then \
	    echo "Error in Makefile: NAME variable is unset." ;\
	    false ;\
	fi
	cp -a gnome/${NAME}/ ${DESTDIR}/usr/share/backgrounds/
	install -D -m 0644 gnome/dynamic-wallpaper-branding-openSUSE.xml ${DESTDIR}/usr/share/gnome-background-properties/dynamic-wallpaper-branding-openSUSE.xml
	ln -sf /usr/share/backgrounds/${NAME}/${NAME}.xml ${DESTDIR}/usr/share/wallpapers/openSUSE-default-dynamic.xml
	## End xml files used by GNOME

	mkdir -p ${DESTDIR}/usr/share/kde4/apps/SUSEgreeter
	cp -p SUSEgreeter/* ${DESTDIR}/usr/share/kde4/apps/SUSEgreeter

	install -d ${DESTDIR}/usr/share/YaST2/theme/openSUSE
	cp -a yast_wizard ${DESTDIR}/usr/share/YaST2/theme/openSUSE/wizard

	install -d ${DESTDIR}/usr/share/grub2/backgrounds/${THEME} ${DESTDIR}/boot/grub2/backgrounds/${THEME}
	cp -a grub2/backgrounds/* ${DESTDIR}/usr/share/grub2/backgrounds/${THEME}
	install -d ${DESTDIR}/usr/share/grub2/themes/${THEME} ${DESTDIR}/boot/grub2/themes/${THEME}
	cp -a grub2/theme/* ${DESTDIR}/usr/share/grub2/themes/${THEME}
	perl -pi -e "s/THEME_NAME/${THEME}/" ${DESTDIR}/usr/share/grub2/themes/${THEME}/activate-theme

	mkdir -p ${DESTDIR}/usr/share/plymouth/themes/${THEME}
	cp -a plymouth/theme/* ${DESTDIR}/usr/share/plymouth/themes/${THEME}

	install -d ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes
	cp -a ksplashx ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse
	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1600x1200	
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1600x1200.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1600x1200/background.jpg
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1920x1200.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1920x1200/background.jpg
	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1280x1024
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1280x1024.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1280x1024/background.jpg
	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1920x1080
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1920x1080.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1920x1080/background.jpg

	mkdir -p ${DESTDIR}/usr/share/kde4/apps
	cp -a kdm ${DESTDIR}/usr/share/kde4/apps/kdm
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1600x1200.jpg ${DESTDIR}/usr/share/kde4/apps/kdm/themes/openSUSE/background-1600x1200.jpg
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1920x1200.jpg ${DESTDIR}/usr/share/kde4/apps/kdm/themes/openSUSE/background-1920x1200.jpg
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1280x1024.jpg ${DESTDIR}/usr/share/kde4/apps/kdm/themes/openSUSE/background-1280x1024.jpg
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1920x1080.jpg ${DESTDIR}/usr/share/kde4/apps/kdm/themes/openSUSE/background-1920x1080.jpg

	install -d ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes
	cp -a ksplash-qml ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplash-qml-openSUSE
	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplash-qml-openSUSE/images
	ln -sf /usr/share/wallpapers/openSUSEdefault/contents/images/1920x1200.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplash-qml-openSUSE/images/background.jpg

	install -D xfce/splash.png ${DESTDIR}/usr/share/pixmaps/xfce4-splash-openSUSE.png

clean: ${CLEAN_DEPS}
	rmdir openSUSE

check: # do not add requires here, this runs from generated openSUSE
	## Check GNOME-related xml files have contant that make sense
	# Check that the link for the dynamic wallpaper is valid
	LINK_TARGET=`readlink --canonicalize ${DESTDIR}/usr/share/wallpapers/openSUSE-default-dynamic.xml` ; \
	test -f "$${LINK_TARGET}" || { echo "The link for openSUSE-default-dynamic.xml is invalid. Please fix it, or contact the GNOME team for help."; exit 1 ;}

	# Check that all files referenced in xml files actually exist
	for xml in ${DESTDIR}/usr/share/wallpapers/openSUSE-default-static.xml ${DESTDIR}/usr/share/wallpapers/openSUSE-default-dynamic.xml; do \
	  xml_basename=`basename $${xml}` ; \
	  for file in `sed "s:<[^>]*>::g" $${xml} | grep /usr`; do \
	      test -f ${DESTDIR}/$${file} || { echo "$${file} is mentioned in $${xml_basename} but does not exist. Please update $${xml_basename}, or contact the GNOME team for help."; exit 1 ;} ; \
	  done ; \
	done

	# Check that xml files reference all relevant files
	for file in ${DESTDIR}/usr/share/wallpapers/openSUSEdefault/contents/images/*.jpg; do \
	   IMG=$${file#${DESTDIR}} ; \
	   grep -q $${IMG} ${DESTDIR}/usr/share/wallpapers/openSUSE-default-static.xml || { echo "$${IMG} not mentioned in openSUSE-default-static.xml. Please add it there, or contact the GNOME team for help." ; exit 1 ;} ; \
	done

	for file in ${DESTDIR}/usr/share/backgrounds/${NAME}/*.jpg; do \
	   IMG=$${file#${DESTDIR}} ; \
	   grep -q $${IMG} ${DESTDIR}/usr/share/wallpapers/openSUSE-default-dynamic.xml || { echo "$${IMG} not mentioned in openSUSE-default-dynamic.xml. Please add it there, or contact the GNOME team for help." ; exit 1 ;} ; \
	done
	## End check of GNOME-related xml files
