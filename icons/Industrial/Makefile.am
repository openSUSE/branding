SUBDIRS=16x16 22x22 24x24 32x32 48x48 cursors scalable

THEME_IN_FILES=index.theme.in

%.theme:   %.theme.in $(INTLTOOL_MERGE) $(wildcard $(top_srcdir)/po/*.po) ; $(INTLTOOL_MERGE) $(top_srcdir)/po $< $@ -d -u -c $(top_builddir)/po/.intltool-merge-cache

icondir=$(datadir)/icons/Industrial
icon_DATA=index.theme
EXTRA_DIST=$(THEME_IN_FILES)

CLEANFILES = index.theme
