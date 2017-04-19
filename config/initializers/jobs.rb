Dir[Rails.root.join("app/jobs/periodic/**/*.rb")].each do |file|
  begin
    require file
    instance = Object.const_get(ActiveSupport::Inflector.camelize("periodic/" + Pathname.new(file).relative_path_from(Rails.root.join('app/jobs/periodic')).to_s.sub(/\..*/, '')))
    instance.new.schedule
  rescue Exception => e
    Rails.logger.error "JOB ERROR: #{file}".yellow
    Rails.logger.error e.message.red
    Rails.logger.error e.backtrace.join("\n").blue
    Logger.new(STDOUT).error "JOB ERROR: #{file}".yellow
  end
end
