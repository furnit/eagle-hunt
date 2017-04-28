class TempPasswordToken
  cattr_accessor :current_user
  @current_user = nil

  def initialize current_user
    @current_user = current_user
  end

  def sent? 
    @current_user and @current_user.temp_password_token_sent_at
  end
  
  def is_valid?
    return false if not @current_user.temp_password_token_sent_at
    return true if @current_user.temp_password_token_confirmed_at < eval(AppConfig.passwords.temp_token_expiration)
    return false
  end
  
  def ticket_value
    return nil if not(@current_user.temp_password_token_sent_at and @current_user.temp_password_token_confirmed_at)
    Digest::SHA256.new << (@current_user.temp_password_token_confirmed_at.to_s + @current_user.temp_password_token_sent_at.to_s + Rails.application.config.secret_key_base)    
  end
  
  def verified? params, exception: true
    if not(@current_user and @current_user.temp_password_token_sent_at)
      return false if not exception
      raise Acu::Errors::AccessDenied.new('temporary password token has not been sent!');
    elsif not @current_user.temp_password_token_confirmed_at
      if params[TempPasswordToken.input_name] != @current_user.temp_password_token
        return false if not exception
        raise Acu::Errors::AccessDenied.new('invalid temporary password!');
      else
        @current_user.temp_password_token_confirmed_at = Time.now
        @current_user.save
        return true
      end
    else
      if @current_user.temp_password_token_confirmed_at < eval(AppConfig.passwords.temp_token_expiration)
        return true
      else
        if params[TempPasswordToken.ticket_name] == TempPasswordToken.ticket_value
          return true
        end
        return false if not exception
        raise Acu::Errors::AccessDenied.new('invalid temporary password!');
      end
    end
  end
  
  def self.ticket_name
    :"l#{Digest::SHA256.new << ("TempPasswordToken" + Rails.application.config.secret_key_base)}"
  end
  
  def self.input_name
    :temp_password_token
  end
end