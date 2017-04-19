class PeriodicJob < ApplicationJob 
  queue_as :default
  
  after_perform do |job|
    job.schedule
  end
  
  def schedule
  end
end