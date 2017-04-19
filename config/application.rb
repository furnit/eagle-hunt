require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Viramobl
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    # pre-load app config
    require_relative 'initializers/app_configs.rb'
    
    # 1. forces the browser to redirect HTTP to HTTPS.
    # 2. it also sets your cookies to be marked "secure",
    # 3. and it enables HSTS
    config.force_ssl = Rails.env.production?
    
    # define the route files
    config.paths['config/routes.rb'].concat Dir[Rails.root.join("config/routes/*.rb")]
    
    # load secret base keys
    config.secret_key_base = ((YAML.load(ERB.new(File.read(Rails.root.join('config/secrets.yml'))).result) || {})[Rails.env] || nil)["secret_key_base"]

    # translation directories
    config.i18n.default_locale = :fa
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # add lib to auto-loading path
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # include all extensions
    Dir["#{config.root}/lib/extensions/*.rb"].each {|file| require file }
    
    # setting time zone
    config.time_zone = 'Tehran'
    config.active_record.default_timezone = :utc
  end
end
