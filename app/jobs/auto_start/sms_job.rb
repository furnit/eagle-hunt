class AutoStart::SmsJob < ApplicationJob
  queue_as :urgent
  
  def schedule
    # schedule all un-sent messages into database!
    Admin::Sms.all.each do |sms|
      if sms.is_urgent
        logger.info "[#{Time.now}] sending buried SMS to `#{sms.to}` now!".yellow
        AutoStart::SmsJob.perform_now sms
      else
        logger.info "[#{Time.now}] sending buried SMS to `#{sms.to}` at proper time which is `#{AutoStart::SmsJob.get_proper_time}`!".yellow
        AutoStart::SmsJob.set(wait_until: AutoStart::SmsJob.get_proper_time).perform_later sms
      end
    end
  end
  
  def self.send_urgent message, to:
    # store into database and send the sms
    AutoStart::SmsJob.perform_now Admin::Sms.create(message: message, to: to, is_urgent: true)
  end

  def self.send_proper message, to:
    # check if not proper time?    
    if not is_proper_time?
      # store and send sms with delay
      AutoStart::SmsJob.set(wait_until: get_proper_time).perform_later Admin::Sms.create(message: message, to: to, is_urgent: false)
      # log it!
      logger.info "[#{Time.now}] Delaying sending message to `#{to}` until `#{get_proper_time.to_s}`".yellow
    else
      # if now is proper time? send it urgently :)
      send_urgent message, to: to
    end
  end

  def perform(*args)
    # at least one argument should be provided
    unless args.length
      logger.error "[#{Time.now}] an empty argument provided!".red
      return
    end
    # consider the first argument as sms argument
    sms = args.first
    # validate the instance
    unless sms.is_a? Admin::Sms
      logger.error "[#{Time.now}] expecting that the argument to be instance of `Admin::Sms` but got instance of `#{args.first.class}`".red
      return
    end
    # peform the actual SMS
    if SMS.send sms.message, to: sms.to
      logger.info "[#{Time.now}] Message `#{sms.message}` sent to `#{sms.to}` successfully".green
      # delete the message from database
      sms.destroy
    else
      logger.error "[#{Time.now}] Failed to send message `#{sms.message}` to `#{sms.to}` burying it for later trial".red
      # if the send was not successfull, re-schedule the sending message
      AutoStart::SmsJob.set(wait: 3.minutes).perform_later(sms)
    end
  end
  
  protected
  
  def self.is_proper_time? 
    return Time.now.hour.between? *AppConfig.preference.timing.sms
  end
  
  def self.get_proper_time
    # if now is proper time? return the current time 
    return Time.now if is_proper_time?
    # fetch the prefered hours
    pref_hours = AppConfig.preference.timing.sms;
    # send tomorrow morning, if the `chour` is after `00:00`
    pref_time = Date.today.noon.change(hour: pref_hours[0])
    # send tomorrow morning, if the `chour` is before `00:00`
    pref_time = Date.tomorrow.noon.change(hour: pref_hours[0]) if Time.now.hour > pref_hours[1]
    # return the preferable time
    return pref_time
  end
end
