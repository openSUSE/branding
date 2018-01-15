NAME=tumbleweed
VERSION=15.0
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

openSUSE.d: gfxboot.d grub2.d yast.d wallpaper.d gnome.d xfce.d plymouth.d
	cp Makefile LICENSE openSUSE

openSUSE.d_clean:
	rm -rf openSUSE/Makefile
	rm -rf openSUSE/LICENSE

CLEAN_DEPS+=openSUSE.d_clean

gfxboot.d: defaults
	mkdir -p openSUSE/gfxboot/data-boot/
	cp gfxboot/SourceSansPro-Light.ttf ~/.fonts
	gm convert -quality 100 -interlace None -colorspace YCbCr -geometry 800x600 -sampling-factor 2x2 raw-theme-drop/back-800x600.png openSUSE/gfxboot/data-boot/back.jpg
	mkdir -p openSUSE/gfxboot/data-install
	gm convert -quality 100 -interlace None -colorspace YCbCr -geometry 800x600 -sampling-factor 2x2 raw-theme-drop/back-1440x1080.png openSUSE/gfxboot/data-install/back.jpg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 raw-theme-drop/welcome.png openSUSE/gfxboot/data-install/welcome.jpg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 raw-theme-drop/on.png openSUSE/gfxboot/data-install/on.jpg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 raw-theme-drop/off.png openSUSE/gfxboot/data-install/off.jpg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 raw-theme-drop/glow.png openSUSE/gfxboot/data-install/glow.jpg
	mkdir -p ~/.fonts
	inkscape -D -w 114 -e tmp.png gfxboot/text.svg
	rm ~/.fonts/SourceSansPro-Light.ttf
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 tmp.png openSUSE/gfxboot/data-install/text.jpg
	rm tmp.png

gfxboot.d_clean:
	rm -rf openSUSE/gfxboot

CLEAN_DEPS+=gfxboot.d_clean

grub2.d:
	mkdir -p openSUSE/grub2
	cp -a boot/grub2/theme openSUSE/grub2/

grub2.d_clean:
	rm -rf openSUSE/grub2

CLEAN_DEPS+=grub2.d_clean

PLS=openSUSE/plymouth/theme/openSUSE.script

PLYMOUTH_DEPS=${PLS}

plymouth.d:
	rm -rf openSUSE/plymouth
	mkdir -p openSUSE/plymouth
	cp -av boot/plymouth/theme openSUSE/plymouth/

plymouth.d_clean:
	rm -rf openSUSE/plymouth

CLEAN_DEPS+=plymouth.d_clean

yast.d:
#	create directly the background from the 4:3 root's blank background
	mkdir -p openSUSE/yast_wizard
	cp -a yast/* openSUSE/yast_wizard

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

	cp raw-theme-drop/desktop-3840x2400.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/3840x2400.jpg

	cp raw-theme-drop/desktop-1280x1024.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1280x1024.jpg
	cp raw-theme-drop/desktop-1600x1200.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1600x1200.jpg
	cp raw-theme-drop/desktop-1920x1080.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1920x1080.jpg
	cp raw-theme-drop/desktop-1920x1200.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1920x1200.jpg
	cp raw-theme-drop/desktop-1350x1080.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1350x1080.jpg
	cp raw-theme-drop/desktop-1440x1080.jpg openSUSE/wallpapers/openSUSEdefault/contents/images/1440x1080.jpg

	ln -sf openSUSEdefault/contents/images/1920x1080.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1080.jpg
	ln -sf openSUSEdefault/contents/images/1920x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1200.jpg
	ln -sf openSUSEdefault/contents/images/1600x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1600x1200.jpg
	cp raw-theme-drop/desktop-1920x1200.jpg openSUSE/wallpapers/openSUSEdefault/screenshot.jpg

wallpaper.d_clean:
	rm -rf openSUSE/wallpapers

CLEAN_DEPS+=wallpaper.d_clean

defaults:

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

gnome.d: # gnome_dynamic
	mkdir -p openSUSE/gnome
	sed "s:@VERSION@:${VERSION}:g;s:@GNOME_STATIC_DYNAMIC@:static:g" gnome/wallpaper-branding-openSUSE.xml.in > openSUSE/gnome/wallpaper-branding-openSUSE.xml
	cp gnome/openSUSE-default-static.xml openSUSE/gnome/openSUSE-default-static.xml
#	sed "s:@VERSION@:${VERSION}:g;s:@GNOME_STATIC_DYNAMIC@:dynamic:g" gnome/wallpaper-branding-openSUSE.xml.in > openSUSE/gnome/dynamic-wallpaper-branding-openSUSE.xml
#	cp -a gnome/dynamic/ openSUSE/gnome/${NAME}

gnome.d_clean:
	rm -rf openSUSE/gnome

CLEAN_DEPS+=gnome.d_clean

xfce.d:
	mkdir -p openSUSE/xfce
	convert 'xfce/splash.png[350x]' openSUSE/xfce/splash.png

xfce.d_clean:
	rm -rf openSUSE/xfce

CLEAN_DEPS+=xfce.d_clean

install: # do not add requires here, this runs from generated openSUSE

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
	
	install -d ${DESTDIR}/usr/share/YaST2/theme/current
	cp -a yast_wizard ${DESTDIR}/usr/share/YaST2/theme/current/wizard

	install -d ${DESTDIR}/usr/share/grub2/themes/${THEME} ${DESTDIR}/boot/grub2/themes/${THEME}
	cp -a grub2/theme/* ${DESTDIR}/usr/share/grub2/themes/${THEME}
	perl -pi -e "s/THEME_NAME/${THEME}/" ${DESTDIR}/usr/share/grub2/themes/${THEME}/activate-theme

	mkdir -p ${DESTDIR}/usr/share/plymouth/themes/${THEME}
	cp -a plymouth/theme/* ${DESTDIR}/usr/share/plymouth/themes/${THEME}

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

	## End check of GNOME-related xml files
