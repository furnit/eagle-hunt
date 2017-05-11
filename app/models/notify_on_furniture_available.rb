class NotifyOnFurnitureAvailable < ApplicationRecord
  belongs_to :admin_furniture
  validates_presence_of :phone_number
  validates_uniqueness_of :admin_furniture_id, scope: :phone_number
  
  validates :phone_number, length: { is: 11 }
  validates_format_of :phone_number, :with => /09\d{2}[- ]?\d{3}[- ]?\d{4}/i
  
  before_validation :normalize_phone_number
  after_initialize :normalize_phone_number

  def helper
    @helper ||= Class.new do
      # include `number_to_phone`
      include ActionView::Helpers::NumberHelper
    end.new
  end
  
  def normalize_phone_number
    return self.phone_number if self.phone_number.nil?
    self.phone_number = helper.number_to_phone(self.phone_number.strip, delimiter: "", pattern: /(\d{4})[- ]?(\d{3})[- ]?(\d{4})$/)
  end
  
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
      
      if not AutoStart::SmsJob.send_proper message, to: (records.collect { |i| i.phone_number }.join(','))
        Rails.logger.error "unable to send SMS #{__FILE__}/#{__LINE__}"
        return
      end
      
      self.where(admin_furniture_id: id).update(status: 1, updated_at: Time.now)
    end
  end
end
