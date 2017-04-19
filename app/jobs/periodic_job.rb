class PeriodicJob < ApplicationJob 
  queue_as :default
  
  after_perform do |job|
    job.schedule
  end
  
  def schedule
  end
  
  def delay w
    self.enqueue wait: w
  end
  
  def time wv
    self.enqueue wait_until: wv
  end
end