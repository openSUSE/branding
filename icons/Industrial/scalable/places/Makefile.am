
size = scalable
context = places

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	folder.icon		\
	folder.svg		\
	folder-remote.svg	\
	folder-saved-search.svg	\
	user-home.svg

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
