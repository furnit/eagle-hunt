def two_step_auth
  ::TwoStepAuth.new current_user
end

def get_hash *val
  data = val + [Rails.application.config.secret_key_base]
  (Digest::SHA256.new << data.join).to_s 
end
  
def expired? datetime, limit
  datetime + limit < Time.now
end