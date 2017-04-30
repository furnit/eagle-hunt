class TwoStepAuth
  cattr_accessor :current_user
  @current_user = nil

  def initialize current_user
    @current_user = current_user
    return self
  end

  def sent? 
    @current_user and @current_user.two_step_auth_token_sent_at
    return self
  end
  
  def confirmed?
    @current_user and @current_user.two_step_auth_token_confirmed_at
    return self
  end
  
  def expired? with_margin: false
    flag = (
      not @current_user or
      not @current_user.two_step_auth_token or
      not @current_user.two_step_auth_token_sent_at
    )
    # if basic eval indicates expiration, don't proceed 
    return true if flag
    # otherwise
    # if token DIDN'T confirm by user? [i.e we just send it and user didn't fill the detail]
    if @current_user.two_step_auth_token_confirmed_at.nil?
      # check the expiration un-confirmed token by sent time
      return (@current_user.two_step_auth_token_sent_at + eval(AppConfig.passwords.two_step_auth.send_expiration) < Time.now)
    else
      # if user confirmed? check if the confirmation time didn't exceed from the limit
      return (@current_user.two_step_auth_token_confirmed_at + eval(AppConfig.passwords.two_step_auth.confirmed_expiration) < Time.now)
    end
  end
  
  # name: the name of entery in `params` to eval
  # exception: raise exception if `not verified`
  # strict: if set `true` it won't consider blank input for `un-expired` tokens [i.e the token always should be provided!]
  def verified? params, name: nil, exception: true, strict: false
    name ||= TwoStepAuth.input_name
    if expired?
      @current_user and @current_user.reset_two_step_auth.save
      return false if not exception
      raise Acu::Errors::AccessDenied.new('token has been expired!');
    end
    # if not expired and no token provided and non-strict-mode? take it easy and let it pass through
    return true if not @current_user.two_step_auth_token_confirmed_at.nil? and params[name].blank? and not strict
    # compare (param's value if exists or nil if otherwise) with stored token 
    if params[name] != @current_user.two_step_auth_token
      # if no match?
      # reset the token for tight security
      @current_user.reset_two_step_auth.save
      return false if not exception
      raise Acu::Errors::AccessDenied.new('invalid or expired token!');
    end
    # confirm the check
    @current_user.two_step_auth_token_confirmed_at = Time.now
    @current_user.save
    true
  end
  
  def self.input_name
    "two-step-auth"
  end  
end