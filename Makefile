NAME=contours
VERSION=13.3
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
	#inkscape -w 800 -e tmp.png gfxboot/startup.svg
	mkdir -p openSUSE/gfxboot/data-boot/
	cp gfxboot/OpenSans-CondBold.ttf ~/.fonts
	gm convert -quality 100 -interlace None -colorspace YCbCr -geometry 800x600 -sampling-factor 2x2 raw-theme-drop/grub-boot-1440x1080.png openSUSE/gfxboot/data-boot/back.jpg
	#inkscape -w 800 -e tmp.png gfxboot/install.svg
	mkdir -p openSUSE/gfxboot/data-install
	gm convert -quality 100 -interlace None -colorspace YCbCr -geometry 800x600 -sampling-factor 2x2 raw-theme-drop/grub-boot-1440x1080.png openSUSE/gfxboot/data-install/back.jpg
	#inkscape -w 800 -e tmp.png gfxboot/welcome.svg
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 raw-theme-drop/install-boot-800x600.png openSUSE/gfxboot/data-install/welcome.jpg
	mkdir -p ~/.fonts
	inkscape -D -w 114 -e tmp.png gfxboot/text.svg
	rm ~/.fonts/OpenSans-CondBold.ttf
	gm convert -quality 100 -interlace None -colorspace YCbCr -sampling-factor 2x2 tmp.png openSUSE/gfxboot/data-install/text.jpg
	rm tmp.png

gfxboot.d_clean:
	rm -rf openSUSE/gfxboot

CLEAN_DEPS+=gfxboot.d_clean

grub2.d:
	mkdir -p openSUSE/grub2/backgrounds
	cp "raw-theme-drop/grub-boot-1920x1200.png" openSUSE/grub2/backgrounds/default-1610.png 
	cp "raw-theme-drop/grub-boot-1920x1080.png" openSUSE/grub2/backgrounds/default-169.png 
	cp "raw-theme-drop/grub-boot-1350x1080.png" openSUSE/grub2/backgrounds/default-54.png 
	cp "raw-theme-drop/grub-boot-1440x1080.png" openSUSE/grub2/backgrounds/default-43.png 
	cp -a boot/grub2/theme openSUSE/grub2/
	./boot/grub2-branding.sh openSUSE/grub2/backgrounds

grub2.d_clean:
	rm -rf openSUSE/grub2

CLEAN_DEPS+=grub2.d_clean

PLS=openSUSE/plymouth/theme/openSUSE.script

PLYMOUTH_DEPS=${PLS}

plymouth.d:
	rm -rf openSUSE/plymouth
	mkdir -p openSUSE/plymouth
	cp -av boot/plymouth/theme openSUSE/plymouth/
	cp -v raw-theme-drop/plymouth-1920x1200.png openSUSE/plymouth/theme/background-1610.png
	cp -v raw-theme-drop/plymouth-1920x1080.png openSUSE/plymouth/theme/background-169.png
	cp -v raw-theme-drop/plymouth-1440x1080.png openSUSE/plymouth/theme/background-43.png
	cp -v raw-theme-drop/plymouth-1350x1080.png openSUSE/plymouth/theme/background-54.png
	cp -v raw-theme-drop/tumbleweed-logo.png openSUSE/plymouth/theme/logo.png

plymouth.d_clean:
	rm -rf openSUSE/plymouth

CLEAN_DEPS+=plymouth.d_clean

kdelibs.d: defaults
	mkdir -p openSUSE/kdelibs
	cp kdelibs/body-background.png kdelibs/css.diff openSUSE/kdelibs

kdelibs.d_clean:
	rm -rf openSUSE/kdelibs

CLEAN_DEPS+=kdelibs.d_clean

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

	cp raw-theme-drop/desktop-3840x2400.png openSUSE/wallpapers/openSUSEdefault/contents/images/3840x2400.png

	convert -quality 100 -geometry 1280x1024 raw-theme-drop/desktop-1280x1024.png openSUSE/wallpapers/openSUSEdefault/contents/images/1280x1024.jpg
	convert -quality 100 -geometry 1600x1200 raw-theme-drop/desktop-1600x1200.png openSUSE/wallpapers/openSUSEdefault/contents/images/1600x1200.jpg
	convert -quality 100 -geometry 1920x1080 raw-theme-drop/desktop-1920x1080.png openSUSE/wallpapers/openSUSEdefault/contents/images/1920x1080.jpg
	convert -quality 100 -geometry 1920x1200 raw-theme-drop/desktop-1920x1200.png openSUSE/wallpapers/openSUSEdefault/contents/images/1920x1200.jpg
	convert -quality 100 -geometry 1350x1080 raw-theme-drop/desktop-1350x1080.png openSUSE/wallpapers/openSUSEdefault/contents/images/1350x1080.jpg
	convert -quality 100 -geometry 1440x1080 raw-theme-drop/desktop-1440x1080.png openSUSE/wallpapers/openSUSEdefault/contents/images/1440x1080.jpg

	ln -sf openSUSEdefault/contents/images/1920x1080.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1080.jpg
	ln -sf openSUSEdefault/contents/images/1920x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1920x1200.jpg
	ln -sf openSUSEdefault/contents/images/1600x1200.jpg openSUSE/wallpapers/openSUSE${VERSION_NO_DOT}-1600x1200.jpg
	convert -quality 90 -geometry 400x250 raw-theme-drop/desktop-1920x1200.png openSUSE/wallpapers/openSUSEdefault/screenshot.jpg
	cp -p kde-workspace/metadata.desktop openSUSE/wallpapers/openSUSEdefault/metadata.desktop

wallpaper.d_clean:
	rm -rf openSUSE/wallpapers

CLEAN_DEPS+=wallpaper.d_clean


CLEAN_DEPS+=defaults_clean

defaults:

ksplashx.d: defaults
	mkdir -p openSUSE/ksplashx
	sed "s:@VERSION@:${VERSION}:g" ksplashx/Theme.rc.in > openSUSE/ksplashx/Theme.rc
	cp -a ksplashx/1920x1200 openSUSE/ksplashx/
	inkscape -w 260 --export-id=Geeko -C -j -e openSUSE/ksplashx/1920x1200/opensuse-logo.png logo.svg
	convert -geometry 300x250  raw-theme-drop/desktop-1920x1200.png openSUSE/ksplashx/Preview.png

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

gnome.d: # gnome_dynamic
	mkdir -p openSUSE/gnome
	sed "s:@VERSION@:${VERSION}:g;s:@GNOME_STATIC_DYNAMIC@:static:g" gnome/wallpaper-branding-openSUSE.xml.in > openSUSE/gnome/wallpaper-branding-openSUSE.xml
	cp gnome/openSUSE-default-static.xml openSUSE/gnome/openSUSE-default-static.xml
#	sed "s:@VERSION@:${VERSION}:g;s:@GNOME_STATIC_DYNAMIC@:dynamic:g" gnome/wallpaper-branding-openSUSE.xml.in > openSUSE/gnome/dynamic-wallpaper-branding-openSUSE.xml
#	cp -a gnome/dynamic/ openSUSE/gnome/${NAME}

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
	install -D -m 644 kdelibs/body-background.png ${DESTDIR}/usr/share/kde4/apps/kdeui/about/body-background.png

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

	mkdir -p ${DESTDIR}/usr/share/kde4/apps/SUSEgreeter
	cp -p SUSEgreeter/* ${DESTDIR}/usr/share/kde4/apps/SUSEgreeter

	install -d ${DESTDIR}/usr/share/YaST2/theme/current
	cp -a yast_wizard ${DESTDIR}/usr/share/YaST2/theme/current/wizard

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

	## End check of GNOME-related xml files
