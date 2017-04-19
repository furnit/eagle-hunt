class PeriodicJob < ApplicationJob 
  queue_as :default
  
  after_perform do |job|
    job.schedule
  end
  
  def schedule
  end
  
  def wait w
    self.enqueue wait: w
  end
  
  def wait_until wv
    self.enqueue wait_until: wv
  end
end