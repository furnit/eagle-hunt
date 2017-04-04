#!/bin/bash

if [[ -f tmp/env && -f tmp/env.bash ]]; then
	echo "ENV files exists and decrypted"
else
	cd tmp
	if [ ! -f env.gpg ]; then
		echo 'env.gpg does not exists!'
		echo '[ABORT]'
		exit 1
	fi 
	gpg env.gpg && unzip -o env && sudo service nginx reload
	cd ..
fi

source tmp/env.bash

export RAILS_ENV=production

[[ $* == *--db-setup* ]] && rails db:drop && rails db:create && rails db:migrate && rails db:seed

[[ $* == *--assets-clobber* ]] && rails assets:clobber && rails assets:clean

rails assets:precompile

MANUAL_ASSETS=(
	'app/assets/stylesheets/photoswipe/default-skin/default-skin.png'
)

for asset in "${MANUAL_ASSETS[@]}"; do
	cp -v "${asset}" public/assets
done