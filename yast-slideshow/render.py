#!/usr/bin/python

import os
import re

res = '150x150'
files = os.listdir('./')
#make dirs
if not os.path.exists('pic'):
	os.mkdir('pic')
	print x, "created"
for file in files:
	if re.search("svg$",file):
		png = re.sub(r"([^.]*)\.svg$", r"\1.png", file)
		print png
		size = re.sub(r"([^x]*)x.*", r"\1", res)
		cmd = "/usr/bin/inkscape -w %s -h %s -e pic/%s %s" % (size,size,png,file)
		print "rendering %s at %s" % (file,res)
		os.system(cmd)
