require Rails.root.join('lib/deep_struct.rb')

ALL_CONFIG ||= YAML.load(ERB.new(File.read(Rails.root.join('config/config.yml'))).result) || {}
ENV_CONFIG ||= ALL_CONFIG[Rails.env] || {}
AppConfig ||= DeepStruct.new(ENV_CONFIG)
