
size = 24x24
context = actions

iconsdir = $(iconthemedir)/$(size)/$(context)

icons_DATA =					\
	document-open.png

EXTRA_DIST =					\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(iconthemedir)/$(size) && $(ICONMAP) -c $(context))
