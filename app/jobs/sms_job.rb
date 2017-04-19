require Rails.root.join('lib/sms/bootstrap')

class SmsJob < ApplicationJob
  queue_as :default
  
  def self.send_urgent message, to:
    SmsJob.perform_now(message, to)
  end

  def self.send_proper message, to:
    # only send message from 9AM-9PM
    chour = Time.now.hour
    pref_hours = AppConfig.preference.timing.sms;
    
    if not chour.between? *pref_hours
      # send tomorrow morning, if the `chour` is after `00:00`
      pref_time = Date.today.noon.change(hour: pref_hours[0])
      # send tomorrow morning, if the `chour` is before `00:00`
      pref_time = Date.tomorrow.noon.change(hour: pref_hours[0]) if chour > pref_hours[1]
      # send message with delay
      SmsJob.set(wait_until: pref_time).perform_later(message, to)
      # log it!
      logger.info "[#{Time.now}] Delaying sending message to `#{to}` until `#{pref_time.to_s}`".yellow
    else
      send_urgent message, to: to
    end
  end

  def perform(*args)
    message, to = *args
    # peform the actual SMS
    if SMS.send message, to: to
      logger.info "[#{Time.now}] Message `#{message}` sent to `#{to}` successfully".green
    else
      logger.error "[#{Time.now}] Failed to send message `#{message}` to `#{to}`".red
    end
  end
end
