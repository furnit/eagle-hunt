class ApplicationJob < ActiveJob::Base
  rescue_from(StandardError) do |e|
    logger.error "JOB ERROR: #{self.class.name}".yellow
    logger.error e.message.red
    logger.error e.backtrace.join("\n").blue
  end
end
