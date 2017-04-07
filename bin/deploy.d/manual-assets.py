#!/usr/bin/env python

import os, shutil

MANUAL_ASSETS = [
	['app/assets/stylesheets/photoswipe/default-skin/default-skin.png', 'public/assets/admin']
]

print "\nmanual assets:\n"

for asset in MANUAL_ASSETS:
	os.system('mkdir -p "%s"' %asset[1])
	shutil.copy2(asset[0], asset[1])
	print "%s -> %s" %(asset[0], asset[1])