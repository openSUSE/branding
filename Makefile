VERSION=15.1
VERSION_NO_DOT=`echo ${VERSION} | sed 's:\.:_:g'`
THEME=SLE

all: info SLE.tar.xz

info:
	echo "Make sure to have inkscape, GraphicsMagick and optipng installed"

SLE.tar.xz: SLE.d
	tar cvfJ SLE.tar.xz SLE
	rm -r SLE

SLE.tar.xz_clean:
	rm -f SLE.tar.xz

CLEAN_DEPS+=SLE.tar.xz_clean

#SLE.d: gfxboot.d grub2.d kdelibs.d wallpaper.d ksplashx.d ksplash-qml.d kdm.d gnome.d susegreeter.d xfce.d plymouth.d
SLE.d: gfxboot.d grub2.d wallpaper.d plymouth.d gdm.d gnome.d 
	cp Makefile LICENSE SLE

SLE.d_clean:
	rm -rf SLE/Makefile
	rm -rf SLE/LICENSE

CLEAN_DEPS+=SLE.d_clean

gdm.d: gdm/custom.conf gdm/distributor.svg
	mkdir -p SLE/gdm
	cp -a gdm SLE

gdm.d_clean:
	rm -rf SLE/gdm

CLEAN_DEPS+=gdm.d_clean


gfxboot.d: gfxboot/back.jpg gfxboot/welcome.jpg gfxboot/text.jpg
	mkdir -p SLE/gfxboot/data-boot/
# gfxboot need jpg files in a "simple" format
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 gfxboot/back.jpg SLE/gfxboot/data-boot/back.jpg
	mkdir -p SLE/gfxboot/data-install
	cp SLE/gfxboot/data-boot/back.jpg SLE/gfxboot/data-install/back.jpg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 gfxboot/back.jpg SLE/gfxboot/data-install/back.jpg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 gfxboot/welcome.jpg SLE/gfxboot/data-install/welcome.jpg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 gfxboot/text.jpg SLE/gfxboot/data-install/text.jpg

gfxboot.d_clean:
	rm -rf SLE/gfxboot

CLEAN_DEPS+=gfxboot.d_clean

grub2.d: grub2/backgrounds/default-*.png
	mkdir -p SLE/grub2/backgrounds
	cp -f grub2/backgrounds/default-*.png SLE/grub2/backgrounds/
	optipng -o4 SLE/grub2/backgrounds/default-*.png
	cp -a grub2/theme SLE/grub2/
	./grub2/grub2-branding.sh SLE/grub2/backgrounds

grub2.d_clean:
	rm -rf SLE/grub2

CLEAN_DEPS+=grub2.d_clean

PLS=SLE/plymouth/theme/SLE.script

SLE/plymouth/theme/SLE.script: plymouth/theme/SLE.*
	mkdir -p SLE/plymouth/theme
	cp -a plymouth/theme/{SLE.*,background.png,box.png,bullet.png,entry.png,lock.png,logo.png,progress*.png,suspend.png} SLE/plymouth/theme/

PLYMOUTH_DEPS=${PLS}

SLE/plymouth/theme/%.png: plymouth/theme/%.png ${PLS}
	optipng -o4 $< -out $@

PLYMOUTH_DEPS+=SLE/plymouth/theme/blank-background-1610.png SLE/plymouth/theme/logo-1610.png

PLYMOUTH_DEPS+=SLE/plymouth/theme/blank-background-169.png SLE/plymouth/theme/logo-169.png

PLYMOUTH_DEPS+=SLE/plymouth/theme/blank-background-54.png SLE/plymouth/theme/logo-54.png

PLYMOUTH_DEPS+=SLE/plymouth/theme/blank-background-43.png SLE/plymouth/theme/logo-43.png

plymouth.d: ${PLYMOUTH_DEPS}

plymouth.d_clean:
	rm -rf SLE/plymouth

CLEAN_DEPS+=plymouth.d_clean

kdelibs.d: defaults
	mkdir -p SLE/kdelibs
	cp wallpapers/SLEdefault/contents/images/1600x1200.jpg SLE/kdelibs/body-background.jpg 
	cp kdelibs/css.diff SLE/kdelibs

kdelibs.d_clean:
	rm -rf SLE/kdelibs

CLEAN_DEPS+=kdelibs.d_clean

wallpaper.d: defaults
	mkdir -p SLE/wallpapers
	mkdir -p SLE/wallpapers/SLEdefault/contents/images
	for res in 1280x1024 1600x1200 1920x1200 1920x1080 ; do \
		cp wallpapers/SLEdefault/contents/images/$${res}.jpg SLE/wallpapers/SLEdefault/contents/images/$${res}.jpg ;\
		sed "s:@VERSION@:${VERSION}:g;s:@VERSION_NO_DOT@:${VERSION_NO_DOT}:g" wallpapers/SLE-$${res}.jpg.desktop.in > SLE/wallpapers/SLE-${VERSION_NO_DOT}-$${res}.jpg.desktop ;\
		ln -sf SLEdefault/contents/images/$${res}.jpg SLE/wallpapers/SLE-${VERSION_NO_DOT}-$${res}.jpg ;\
	done
	convert -quality 90 -geometry 400x250 wallpapers/SLEdefault/contents/images/1920x1200.jpg SLE/wallpapers/SLEdefault/screenshot.jpg

wallpaper.d_clean:
	rm -rf SLE/wallpapers

CLEAN_DEPS+=wallpaper.d_clean

#default-1280x1024.jpg: background-54.svg
#	inkscape -e default-1280x1024.png -w 1280 background-54.svg
#	convert -quality 100 -geometry 1280x1024 default-1280x1024.png default-1280x1024.jpg
#	rm default-1280x1024.png

#default-1600x1200.jpg: background-43.svg
#	inkscape -e default-1600x1200.png -w 1600 background-43.svg
#	convert -quality 100 -geometry 1600x1200 default-1600x1200.png default-1600x1200.jpg
#	rm default-1600x1200.png

#default-1920x1080.jpg: background-169.svg
#	inkscape -e default-1920x1080.png -w 1920 background-169.svg
#	convert -quality 100 -geometry 1920x1080 default-1920x1080.png default-1920x1080.jpg
#	rm default-1920x1080.png

#default-1920x1200.jpg: background-1610.svg
#	inkscape -e default-1920x1200.png -w 1920 background-1610.svg
#	convert -quality 100 -geometry 1920x1200 default-1920x1200.png default-1920x1200.jpg
#	rm default-1920x1200.png

# When changing the commands below, also update the commands in gnome_dynamic
defaults: wallpapers/SLEdefault/contents/images/1280x1024.jpg wallpapers/SLEdefault/contents/images/1600x1200.jpg wallpapers/SLEdefault/contents/images/1920x1200.jpg wallpapers/SLEdefault/contents/images/1920x1080.jpg

defaults_clean:
	rm -f default-1280x1024.jpg
	rm -f default-1600x1200.jpg
	rm -f default-1920x1080.jpg
	rm -f default-1920x1200.jpg

CLEAN_DEPS+=defaults_clean

ksplashx.d: defaults
	mkdir -p SLE/ksplashx
	sed "s:@VERSION@:${VERSION}:g" ksplashx/Theme.rc.in > SLE/ksplashx/Theme.rc
	cp -a ksplashx/1920x1200 SLE/ksplashx/
	inkscape -w 260 --export-id=Geeko -C -j -e SLE/ksplashx/1920x1200/opensuse-logo.png logo.svg
	convert -geometry 300x250 default-1920x1200.jpg SLE/ksplashx/Preview.png

ksplashx.d_clean:
	rm -rf SLE/ksplashx

CLEAN_DEPS+=ksplashx.d_clean

#This is called SLE
kdm.d: defaults
	mkdir -p SLE/kdm/themes/SLE
	cp -a kdm/* SLE/kdm/themes/SLE
	cp -r SLE/kdm/themes/SLE/pics/* SLE/kdm/
	rm -rf SLE/kdm/themes/SLE/pics

kdm.d_clean:
	rm -rf SLE/kdm

CLEAN_DEPS+=kdm.d_clean

ksplash-qml.d: 
	mkdir -p SLE/ksplash-qml
	sed "s:@VERSION@:${VERSION}:g" ksplash-qml/Theme.rc.in > SLE/ksplash-qml/Theme.rc
	cp ksplash-qml/main.qml SLE/ksplash-qml/main.qml
	cp ksplash-qml/Preview.png SLE/ksplash-qml/Preview.png
	cp -a ksplash-qml/images SLE/ksplash-qml/

ksplash-qml.d_clean:
	rm -rf SLE/ksplash-qml

CLEAN_DEPS+=ksplash-qml.d_clean

gnome.d: 
	mkdir -p SLE/gnome
	sed "s:@VERSION@:${VERSION}:g" gnome/wallpaper-branding-SLE.xml.in > SLE/gnome/wallpaper-branding-SLE.xml
	cp gnome/SLE-default-static.xml SLE/gnome/SLE-default-static.xml

gnome.d_clean:
	rm -rf SLE/gnome

CLEAN_DEPS+=gnome.d_clean

susegreeter.d:
	mkdir -p SLE/SUSEgreeter
	inkscape -w 800 -e SLE/SUSEgreeter/background.png kde-workspace/SUSEgreeter/background.svg

susegreeter.d_clean:
	rm -rf SLE/SUSEgreeter

CLEAN_DEPS+=susegreeter.d_clean

install: # do not add requires here, this runs from generated SLE
	install -d ${DESTDIR}/usr/share/wallpapers
	cp -a wallpapers/* ${DESTDIR}/usr/share/wallpapers

	## Install xml files used by GNOME to find default wallpaper
	# Here's the setup we use:
	#  - /usr/share/wallpapers/SLE-default.xml is the default background
	#
	# Static wallpaper
	install -D -m 0644 gnome/wallpaper-branding-SLE.xml ${DESTDIR}/usr/share/gnome-background-properties/wallpaper-branding-SLE.xml
	install -m 0644 gnome/SLE-default-static.xml ${DESTDIR}/usr/share/wallpapers/SLE-default-static.xml
	## End xml files used by GNOME

	install -d ${DESTDIR}/usr/share/grub2/backgrounds/${THEME} ${DESTDIR}/boot/grub2/backgrounds/${THEME}
	cp -a grub2/backgrounds/* ${DESTDIR}/usr/share/grub2/backgrounds/${THEME}
	install -d ${DESTDIR}/usr/share/grub2/themes/${THEME} ${DESTDIR}/boot/grub2/themes/${THEME}
	cp -a grub2/theme/* ${DESTDIR}/usr/share/grub2/themes/${THEME}
	perl -pi -e "s/THEME_NAME/${THEME}/" ${DESTDIR}/usr/share/grub2/themes/${THEME}/activate-theme

	mkdir -p ${DESTDIR}/usr/share/plymouth/themes/${THEME}
	cp -a plymouth/theme/* ${DESTDIR}/usr/share/plymouth/themes/${THEME}

#	install -d ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes
#	cp -a ksplashx ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse
#	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1600x1200	
#	ln -sf /usr/share/wallpapers/SLEdefault/contents/images/1600x1200.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1600x1200/background.jpg
#	ln -sf /usr/share/wallpapers/SLEdefault/contents/images/1920x1200.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1920x1200/background.jpg
#	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1280x1024
#	ln -sf /usr/share/wallpapers/SLEdefault/contents/images/1280x1024.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1280x1024/background.jpg
#	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1920x1080
#	ln -sf /usr/share/wallpapers/SLEdefault/contents/images/1920x1080.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplashx-suse/1920x1080/background.jpg

#	install -d ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes
#	cp -a ksplash-qml ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplash-qml-SLE
#	mkdir -p ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplash-qml-SLE/images
#	ln -sf /usr/share/wallpapers/SLEdefault/contents/images/1920x1200.jpg ${DESTDIR}/usr/share/kde4/apps/ksplash/Themes/ksplash-qml-SLE/images/background.jpg


clean: ${CLEAN_DEPS}
	rmdir SLE 2> /dev/null || :

check: # do not add requires here, this runs from generated SLE
	# Check that all files referenced in xml files actually exist
	for xml in ${DESTDIR}/usr/share/wallpapers/SLE-default-static.xml ${DESTDIR}/usr/share/wallpapers/SLE-default-dynamic.xml; do \
	  xml_basename=`basename $${xml}` ; \
	  for file in `sed "s:<[^>]*>::g" $${xml} | grep /usr`; do \
	      test -f ${DESTDIR}/$${file} || { echo "$${file} is mentioned in $${xml_basename} but does not exist. Please update $${xml_basename}, or contact the GNOME team for help."; exit 1 ;} ; \
	  done ; \
	done

	# Check that xml files reference all relevant files
	for file in ${DESTDIR}/usr/share/wallpapers/SLEdefault/contents/images/*.jpg; do \
	   IMG=$${file#${DESTDIR}} ; \
	   grep -q $${IMG} ${DESTDIR}/usr/share/wallpapers/SLE-default-static.xml || { echo "$${IMG} not mentioned in SLE-default-static.xml. Please add it there, or contact the GNOME team for help." ; exit 1 ;} ; \
	done

	## End check of GNOME-related xml files
