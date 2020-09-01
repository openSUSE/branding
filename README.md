![Wallpaper](/wallpapers/SLEdefault/contents/images/1280x1024.jpg)

Workflow process
================
A complete workflow process in available in the master branch README
(visible from the home page of the github repository)

Important files
===============

  default*.jpg: wallpapers, also used by various svg in subdirectories

-----------------------------------------------------------------------

How to update the wallpaper in the distribution
===============================================

1) Create SLE.tar.gz with make

Simply type 'make' to create SLE.tar.xz:

  pushd branding
  git checkout sle-15-sp3
  make
  popd

2) Update the data in the branding-SLE package

The following commands will branch the branding-SLE package, commit the new
data and submit the changes:

  osc branch SUSE:SLE-15-SP3:GA branding-SLE -c
  cp branding/SLE.tar.xz home:*branches*/branding-SLE
  cd home:*branches*/branding-SLE
  osc vc
  osc ci
  osc sr
    -> created request id XXXXX


How to create artwork for a new version of SLE
===================================================

Simply copy all files from this directory to a new directory, and change:

 - the NAME variable at the top of Makefile to the name of the artwork theme
   for the version of openSUSE you target.
 - the VERSION variable at the top of Makefile to the version of openSUSE you
   target.


Need help?
==========

If you need help with packaging the artwork, you can contact the following
people:

  Frederic Crozat (fcrozat@suse.com)
