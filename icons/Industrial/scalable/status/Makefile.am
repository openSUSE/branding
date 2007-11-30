
size = scalable
context = status

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	folder-drag-accept.svg	\
	folder-open.svg		\
	folder-visiting.svg

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
