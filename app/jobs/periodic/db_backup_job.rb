class Periodic::DbBackupJob < PeriodicJob
  
  def schedule
    # backup database everyday at `4:00 AM`
    time Date.tomorrow.noon.change hour: 4
  end
  
  def perform(*args)
    `/bin/bash -c "cd #{Rails.root} && source tmp/env.bash && RAILS_ENV=#{Rails.env} bundle exec rake db:backup --silent"`
  end
end
