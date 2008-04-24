
size = 24x24
context = actions

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =					\
	document-open.png \
	folder-new.png

EXTRA_DIST =					\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
