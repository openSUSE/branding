![Wallpaper](/raw-theme-drop/desktop-1280x1024.jpg)

#Workflow process

A complete workflow process in available in the master branch README
(visible from the home page of the github repository)

##Important files

dynamic-wallpaper.xml.in: file is used to create the dynamic wallpaper used by GNOME. See gnome/README for more details.

yast/background.png: a reprise of the wallpaper

##How to update the wallpaper in the distribution

1. Create openSUSE.tar.gz with make

Simply type 'make' to create openSUSE.tar.gz:

```
pushd branding
git checkout leap-15
make
popd
```

2. Update the data in the branding-openSUSE package

The following commands will branch the branding-openSUSE package, commit the new data and submit the changes:

```
osc branch openSUSE:Factory branding-openSUSE -c
cp branding/openSUSE.tar.gz home:*branches*/branding-openSUSE
cd home:*branches*/branding-openSUSE
osc vc
osc ci
osc sr
```

##How to create artwork for a new version of openSUSE

Simply copy all files from this directory to a new directory, and change:

- the NAME variable at the top of Makefile to the name of the artwork theme for the version of openSUSE you target.
- the VERSION variable at the top of Makefile to the version of openSUSE you target.


#Need help?

If you need help with packaging the artwork, you can contact the following
people:

- Stephan Kulow <[coolo@suse.de](mailto:coolo@suse.de)>
- Vincent Untz <[vuntz@opensuse.org](mailto:vuntz@opensuse.org)>
- Richard Brown <[rbrownccb@opensuse.org](mailto:rbrownccb@opensuse.org)>
