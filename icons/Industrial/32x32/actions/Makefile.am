
size = 32x32
context = actions

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	document-open.png

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))

