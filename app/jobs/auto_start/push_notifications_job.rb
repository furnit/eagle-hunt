class AutoStart::PushNotificationsJob < ApplicationJob
  queue_as :urgent

  def schedule
    # schedule all un-sent nofitications from database!
    Thread.new do
      Admin::PushNotification.where(sent_at: nil).each do |notif|
        AutoStart::PushNotificationsJob.perform_now notif
      end
    end
  end

  def self.push message, category: :admin_notifications
    Thread.new do
      # store into database and send the notification
      AutoStart::PushNotificationsJob.perform_now Admin::PushNotification.create(message: message, category: category)
    end
  end

  def perform(*args)
    # at least one argument should be provided
    unless args.length
      logger.error "[#{Time.now}] an empty argument provided!".red
      return
    end
    # consider the first argument as sms argument
    notif = args.first
    # validate the instance
    unless notif.is_a? Admin::PushNotification
      logger.error "[#{Time.now}] expecting that the argument to be instance of `Admin::PushNotification` but got instance of `#{notif.class}`".red
      return
    end
    # peform the actual notification push
    if action_push notif.message, notif.category
      logger.info "[#{Time.now}] Notification `#{notif.message}` pushed successfully".green
      # flag the notification that sent
      notif.sent_at = Time.now
      notif.save
    else
      logger.error "[#{Time.now}] Failed to push notification `#{notif.message}` burying it for later trial".red
      # if the send was not successfull, re-schedule the sending message
      Admin::PushNotification.set(wait: 3.minutes).perform_later(notif)
    end
  end

  protected

    def action_push message, category
      case AppConfig.notifications.prefered.to_sym
      when :telegram
        config = AppConfig.notifications[AppConfig.notifications.prefered]
        res = JSON.parse Curl.get("https://api.telegram.org/bot#{config[category].token}/sendMessage", data: {chat_id: config.chat_id, text: message}).body
        if not res["ok"]
          if AutoStart::SmsJob.send_urgent "Failed to send push notifications to telegeram!\ncategory:#{category}\nmessage:\n#{message}", to: Admin::UserType.where(symbol: :ADMIN).first.users.map { |u| u.phone_number }.join(',')
            return true
          end
          return false
        end
        return true
      else
        AutoStart::SmsJob.send_urgent "Not implemented push notification method #{AppConfig.notification.prefered}", to: Admin::UserType.where(symbol: :ADMIN).first.users.map { |u| u.phone_number }.join(',')
      end
    end
end
