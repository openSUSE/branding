
size = scalable
context = status

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	folder-visiting.png

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
