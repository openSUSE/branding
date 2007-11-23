
size = 16x16
context = status

iconsdir = $(iconthemedir)/$(size)/$(context)

icons_DATA =			\
	folder-drag-accept.png	\
	folder-visiting.png

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(iconthemedir)/$(size) && $(ICONMAP) -c $(context))

