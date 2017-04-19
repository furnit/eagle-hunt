class Periodic::DbBackupJob < PeriodicJob
  
  def schedule
    # schedule the 
    # wait_until Date.tomorrow.noon.change hour: 3
  end
  
  def perform(*args)
    ActiveRecord::Base.connection.tables.each do |t|
      ap [t, t.classify]
    end
  end
end
