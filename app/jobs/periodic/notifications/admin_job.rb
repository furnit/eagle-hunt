require Rails.root.join('lib/sms/bootstrap')

class Periodic::Notifications::AdminJob < PeriodicJob
  
  def schedule
    time Date.tomorrow.noon
  end
  
  def perform(*args)    
    admins = Admin::UserType.where(symbol: :ADMIN).first.users.select(:phone_number)
    
    @message = ""
    
    self.class.instance_methods(false).grep(/notify_/).each do |method|
      bk = @message.dup
      self.send(method)
      @message += "\n" if bk != @message
    end
    
    @message = @message.strip
    
    return if not @message.length > 0
      
    @message = "مدیر گرامی\nآخرین وضعیت سایت:\n" + @message + "\nمبل ویرا\n#{AppConfig.domain}"
    
    SmsJob.send_urgent @message, to: admins.collect {|u| u.phone_number }.join(',')
  end
  
  protected
  
  def notify_employee_unconfirmed_records
    report = ""
    {
      fani: { label: 'فنی', cname: :Fani },
      nagashi: { label: 'نقاشی', cname: :Nagash },
      najar: { label: 'نجاری', cname: :Najar },
    }.each do |k, v|
      count = Object.const_get("Employee::#{v[:cname].to_s}").where(confirmed: 0).count
      report += "#{v[:label]}: #{count}\n" if count != 0
    end
    
    if report.strip.length > 0
      @message = "---\nداده‌های تایید نشده:\n" + report.strip
    end
  end
end
