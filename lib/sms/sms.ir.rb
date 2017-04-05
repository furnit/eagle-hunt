module SMS
  class << self
    
  def send message, to:
    to = [to].flatten
    message = message.strip
    return if not to.length
    raise Exception.new("you cannot send an empty message!") if not message.length
    
    params = {
      user: AppConfig.sms_api.sms_ir.username,
      pass: AppConfig.sms_api.sms_ir.password, 
      funcName: :SendSMSToACustomerClub,
      text: message,
      to: to.join(",")
    }
    
    require 'net/http'
    uri = URI.parse("http://ip.sms.ir/SendMessage.ashx")
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    
    return res.is_a? Net::HTTPSuccess 
  end
  
  end
end