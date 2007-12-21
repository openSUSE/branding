
size = 48x48
context = places

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA =			\
	folder.png		\
	folder.icon		\
	folder-remote.png	\
	folder-remote.icon	\
	folder-saved-search.png	\
	folder-saved-search.icon	\
	user-home.png		\
	user-home.icon

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))
