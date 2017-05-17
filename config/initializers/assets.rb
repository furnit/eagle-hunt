# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

# precompile directories

%w(
  photoswipe
  users
  filterrific
  employee
  admin
  shared
  vendors
  image_upload
).each do |directory|
  Rails.application.config.assets.precompile += [ "#{directory}/*.js", "#{directory}/*.css", "#{directory}/*.coffee" ]
end

# Custom couple files to pre-compile
%w(
  texteditor
  bootbox-delete-confirm
  jquery.fileupload jquery.fileupload-image jquery.fileupload-process jquery.fileupload-ui jquery.fileupload-validate jquery.iframe-transport jquery.ui.widget
  nprogress nprogress-bootstrap nprogress-turbolinks5
  draggable_background
  jquery-ui
  nprogress-ajax-iframe
  moment.min
  jalali.min
  common
  infinit_scroll
).each do |item|
  Rails.application.config.assets.precompile += [ "#{item}.css", "#{item}.js", "#{item}.min.css", "#{item}.min.js" ]
end

# ----------------------- images ----------------------

Rails.application.config.assets.precompile += [
  'filterrific/filterrific-spinner.gif',
  '*.png',
  '*.svg',
  '*.jpg',
  '*.jpeg',
  '*.ico',
  '*.icon'
]

# Controller related files to pre-compile
%w(
  home
  registrations
  sessions
  profiles
  shopping_carts
).each do |controller|
  Rails.application.config.assets.precompile += [ "#{controller}.coffee", "#{controller}.js", "#{controller}.css", "#{controller}.scss" ]
end
