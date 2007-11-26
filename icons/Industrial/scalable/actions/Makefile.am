
size = scalable
context = actions

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =					\
	document-open.svg

EXTRA_DIST =					\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
