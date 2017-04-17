class NotifyOnFurnitureAvailable < ApplicationRecord
  belongs_to :admin_furniture
  validates_presence_of :phone_number
  validates_uniqueness_of :admin_furniture_id, scope: :phone_number
  
  include Rails.application.routes.url_helpers
  
  def self.notify_for_furniture id, name
    Thread.new do
      require "#{Rails.root}/lib/sms/bootstrap"
      
      message = <<~sms
        محصول «#{name}» قابل سفارش شد!
        
        شماره محصول: #{id}
        
        مبل ویرا
        #{AppConfig.domain}
      sms

      # users that have not been sent any notification or haven't sent the notification in the past month!  
      records = self.where("admin_furniture_id = ? and (status != ? or updated_at < ?)", id, 1, 1.months.ago);
      
      return if records.empty?
      
      if not SMS.send message, to: (records.collect { |i| i.phone_number }.join(','))
        Rails.logger.error "unable to send SMS #{__FILE__}/#{__LINE__}"
        return
      end
      
      self.where(admin_furniture_id: id).update(status: 1, updated_at: Time.now)
    end
  end
end
