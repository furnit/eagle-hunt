class TwoStepAuth
  cattr_accessor :current_user
  @current_user = nil

  def initialize current_user
    @current_user = current_user
    return self
  end

  def sent? 
    @current_user and @current_user.temp_password_token_sent_at
    return self
  end
  
  def verified? params, name: nil, exception: true
    name ||= TwoStepAuth.input_name
    if not(@current_user and @current_user.two_step_auth_token_sent_at)
      @current_user.reset_two_step_auth.save
      return false if not exception
      raise Acu::Errors::AccessDenied.new('token has not been sent!');
    else
      if (params[name] != @current_user.two_step_auth_token) or (@current_user.two_step_auth_token_sent_at < eval(AppConfig.passwords.two_step_auth.expiration))
        @current_user.reset_two_step_auth.save
        return false if not exception
        raise Acu::Errors::AccessDenied.new('invalid or expired token!');
      else
        @current_user.reset_two_step_auth.save
        return true
      end
    end
  end
  
  def self.input_name
    "two-step-auth"
  end
end