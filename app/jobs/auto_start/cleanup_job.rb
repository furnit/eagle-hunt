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
    Admin::UploadedFile.where("not owned and updated_at < ?", 3.days.ago).each do |f|
      begin
        f.destroy
        dir = File.dirname(f.image.file.file);
        Dir.delete dir if Dir["#{dir}/*"].empty?
      rescue
      end
    end
  end
  
end
