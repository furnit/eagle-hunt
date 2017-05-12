require 'net/http'

module SMS
  class << self
    
  def send message, to:
    to = [to].flatten
    message = message.strip
    return if not to.length
    raise Exception.new("you cannot send an empty message!") if not message.length
    
    params = init_params.merge({
      funcName: :SendSMSToACustomerClub,
      text: message,
      to: to.join(",")
    })
    
    is_success? Net::HTTP.get_response(init_uri params)
    
  rescue
    return false
  end
  
  def add_to_phonebook first_name:, last_name:, mobile:
    params = init_params.merge({
      funcName: :InsertNewCustomerClub,
      firstName: first_name,
      lastName: last_name,
      mobile: mobile
    })
    
    is_success? Net::HTTP.get_response(init_uri params)
    
  rescue
    return false   
  end
  
  protected
  
  def init_params
    {
      user: AppConfig.sms_api.sms_ir.username,
      pass: AppConfig.sms_api.sms_ir.password
    }
  end
  
  def init_uri params
    uri = URI.parse("http://ip.sms.ir/SendMessage.ashx")
    uri.query = URI.encode_www_form(params)
    uri
  end
  
  def is_success? res
    (res.is_a? Net::HTTPSuccess and not res.body =~ /system error/) 
  end
  end
end