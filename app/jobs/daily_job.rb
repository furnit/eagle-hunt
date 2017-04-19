class DailyJob < PeriodicJob
  def schedule
    self.enqueue wait_until: Date.tomorrow.noon
  end
end