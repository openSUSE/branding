
size = 256x256
context = places

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	folder.icon		\
	folder.png		\
	folder-remote.png	\
	folder-saved-search.png		\
	user-home.png

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
