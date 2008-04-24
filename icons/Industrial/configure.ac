# Process this file with autoconf to produce a configure script.
AC_PREREQ(2.53)

AC_INIT([industrial-icon-theme], [11.0.5])
AC_CONFIG_SRCDIR(index.theme.in)

AM_INIT_AUTOMAKE([1.9 tar-ustar])

AC_PROG_INTLTOOL([0.33])
PKG_PROG_PKG_CONFIG([0.19])

GETTEXT_PACKAGE="${PACKAGE}"
AC_SUBST(GETTEXT_PACKAGE)

ALL_LINGUAS=""
AM_GLIB_GNU_GETTEXT

# AM_GLIB_GNU_GETTEXT above subst. $DATADIRNAME
# this is the directory where the *.{mo,gmo} files are installed
localedir='${prefix}/${DATADIRNAME}/locale'
AC_SUBST(localedir)

# Workaround to make aclocal get the right flags
AC_SUBST(ACLOCAL_AMFLAGS, "\${ACLOCAL_FLAGS}")

# Define the toplevel path here
AC_SUBST(themedir, "\${datadir}/icons/Industrial")

UTILS_REQUIRED=0.7.0

AC_MSG_CHECKING([icon-naming-utils >= $UTILS_REQUIRED])
PKG_CHECK_EXISTS(icon-naming-utils >= $UTILS_REQUIRED,
                 have_utils=yes, have_utils=no)
if test "x$have_utils" = "xyes"; then
   UTILS_PATH="`$PKG_CONFIG --variable=program_path icon-naming-utils`"
   ICONMAP="$UTILS_PATH/icon-name-mapping"
   AC_SUBST(ICONMAP)
   AC_MSG_RESULT([yes])
else
   AC_MSG_RESULT([no])
   AC_MSG_ERROR([icon-naming-utils >= $UTILS_REQUIRED is required to build
                 and install industrial-icon-theme])
fi

# Check for rsvg or ksvgtopng for creating large scale bitmaps from svg
AC_ARG_ENABLE(png-creation,
   AC_HELP_STRING([--enable-png-creation],
                   [enable creating png images from svg [default=disabled]]),
    enable_large_bitmaps=$enableval,
    enable_large_bitmaps=no)

SVGCONVERT=""
AC_MSG_CHECKING([SVG to PNG conversion method])
if test "x$enable_large_bitmaps" = "xyes"; then
   PKG_CHECK_EXISTS([enable_large_bitmaps=yes], [enable_large_bitmaps=no])
   if test "x$enable_large_bitmaps" = "xyes"; then
      svgconvert_prog="inkscape"
   else
      svgconvert_prog="ksvgtopng"
   fi
   AC_MSG_RESULT([$svgconvert_prog])
   AC_PATH_PROG(SVGCONVERT, $svgconvert_prog)
   if test -z "$SVGCONVERT"; then
      AC_MSG_ERROR([You need inkscape or ksvgtopng installed to create large scale bitmaps])
   else
      enable_large_bitmaps=yes
   fi
else
   AC_MSG_RESULT([none])
fi
AC_SUBST(SVGCONVERT)
AM_CONDITIONAL(ENABLE_LARGE_BITMAPS, test x$enable_large_bitmaps = xyes)

AC_CONFIG_FILES([
Makefile
16x16/Makefile
16x16/actions/Makefile
16x16/places/Makefile
16x16/status/Makefile
22x22/Makefile
22x22/actions/Makefile
22x22/places/Makefile
22x22/status/Makefile
24x24/Makefile
24x24/actions/Makefile
24x24/places/Makefile
24x24/status/Makefile
32x32/Makefile
32x32/actions/Makefile
32x32/places/Makefile
32x32/status/Makefile
48x48/Makefile
48x48/animations/Makefile
48x48/actions/Makefile
48x48/places/Makefile
48x48/status/Makefile
256x256/Makefile
256x256/actions/Makefile
256x256/places/Makefile
256x256/status/Makefile
po/Makefile.in
])	

AC_OUTPUT
