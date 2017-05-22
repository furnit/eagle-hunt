source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use twitter bootstrap for CSS
gem 'bootstrap-sass', '3.3.7'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Devise for session auth.
gem 'devise'
gem 'devise-i18n'
# Use CarrierWave for file uploading
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
# Use AccountingJS for currency formating
gem 'accountingjs-rails'
# Use AutoSize-Rails for auto-resize textarea
gem 'autosize-rails'
# Use WYSIWYG-Rails for text editoring
gem 'wysiwyg-rails'
# Use Font-Awesome for icons
gem "font-awesome-rails"
# For HTML dialog box
gem 'bootbox-rails'
# Act as paranoid for models soft deletions
# gem 'paranoia', github: "rubysherpas/paranoia", branch: 'rails5'
gem 'acts_as_paranoid', github: 'ActsAsParanoid/acts_as_paranoid'
# For making thumbnail with carrierwave
gem 'rmagick'
# For progress bar indicator
gem 'nprogress-rails'
# Auto build bootstrap forms
gem 'bootstrap_form'
# The markup gem
gem 'github-markup', github: 'github/markup'
# The common markers for github markdown
gem 'commonmarker'
# For pagination
gem 'will_paginate', '~> 3.1.0'
# The bootstrap stylish for pagination
gem 'will_paginate-bootstrap'
# Translation for will_paginate
gem 'will-paginate-i18n', github: 'noise2/will-paginate-i18n'
# The access control unit
gem 'rails-acu'
# for filtered search
gem 'filterrific', github: 'ayaman/filterrific'
# for inline editing
gem 'bootstrap-editable-rails' #, github: 'noise2/bootstrap-editable-rails'
# for pretty bootstrap selects
gem 'bootstrap-select-rails'
# for reCAPTCHA
gem 'recaptcha', require: "recaptcha/rails"
# for shorten URLs
gem 'bitly'
# colorizes the string 
gem 'colorize'
# for general schedule purposes 
gem 'whenever', require: false
# for fixing the `openssl.so: warning: already initialized constant` issue caused when backing up the database 
gem 'openssl', '2.0.2'
# for fixing the `bigdecimal.so: warning: already initialized constant` issue caused when backing up the database 
gem 'bigdecimal', '~> 1.1'
# for dependency of `gem 'descriptive_statistics'`
gem 'statistics2', github: 'noise2/statistics2'
# for statistical method, also used by `gem 'savanna-outliers'`
gem 'descriptive_statistics', '~> 2.4.0'
# for outlier detection
gem 'savanna-outliers'
# for clustering purposes
gem 'kmeans-clusterer'
# for meta tagging the pages
gem 'meta-tags'
# for db:session storage
gem 'activerecord-session_store'
# for language detection
gem "cld"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  # For pretty print
  gem 'awesome_print', github: 'awesome-print/awesome_print'
  # for factoring rspec testing units 
  gem "factory_girl_rails"
  # fakes the data for testing
  gem "faker"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # nothing here
  gem 'sqlite3'
end