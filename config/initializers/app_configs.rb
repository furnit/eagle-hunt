ALL_CONFIG = YAML.load_file(Rails.root.join('config/config.yml')) || {}
ENV_CONFIG = ALL_CONFIG[Rails.env] || {}
AppConfig = DeepStruct.new(ENV_CONFIG)
