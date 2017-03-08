# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

# precompile directories
Rails.application.config.assets.precompile += [ 'photoswipe/*', 'custom/*' ]

# Custom couple files to pre-compile
%w(texteditor bootbox-delete-confirm).each do |item|
  Rails.application.config.assets.precompile += [ "#{item}.css", "#{item}.js" ]
end

# Controller related files to pre-compile
%w(home furnitures furniture_types sitting_sets registrations sessions profiles shopping_carts).each do |controller|
  Rails.application.config.assets.precompile += [ "#{controller}.coffee", "#{controller}.js", "#{controller}.css", "#{controller}.scss" ]
end
