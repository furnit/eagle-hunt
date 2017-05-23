class AutoStart::CleanupJob < PeriodicJob
  
  def schedule
    # backup database everyday at `3:30 AM`
    time Date.tomorrow.noon.change hour: 3, min: 30
  end
  
  def perform(*args)
    self.class.instance_methods(false).grep(/cleanup_/).each do |method|
      self.send(method)
    end
  end
  
  protected
  
  def cleanup_uploaded_files
    # carrierwave will take care of the empty directories
    Admin::UploadedFile.where("owned <= 0 and updated_at < ?", 3.days.ago).destroy_all
  end
  
end
