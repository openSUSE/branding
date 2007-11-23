
size = 16x16
context = places

iconsdir = $(iconthemedir)/$(size)/$(context)

icons_DATA =			\
	folder.png		\
	folder-remote.png	\
	folder-saved-search.png	\
	user-home.png

EXTRA_DIST =			\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(iconthemedir)/$(size) && $(ICONMAP) -c $(context))

