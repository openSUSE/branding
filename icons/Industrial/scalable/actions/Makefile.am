
size = scalable
context = actions

iconsdir = $(iconthemedir)/$(size)/$(context)

icons_DATA =					\
	document-open.svg

EXTRA_DIST =					\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(iconthemedir)/$(size) && $(ICONMAP) -c $(context))
