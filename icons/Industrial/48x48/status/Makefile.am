
size = 48x48
context = status

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	folder-drag-accept.png	\
	folder-drag-accept.icon	\
	folder-open.png		\
	folder-open.icon		\
	folder-visiting.png		\
	folder-visiting.icon

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
