
size = 16x16
context = status

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	folder-drag-accept.png	\
	folder-visiting.png

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))

