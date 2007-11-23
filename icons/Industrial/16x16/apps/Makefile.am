
NULL=
size = 16x16
context = apps

iconsdir = $(iconthemedir)/$(size)/$(context)

icons_DATA =					\
	$(NULL)

EXTRA_DIST =					\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(iconthemedir)/$(size) && $(ICONMAP) -c $(context))
