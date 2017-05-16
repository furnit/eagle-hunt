def two_step_auth
  ::TwoStepAuth.new current_user
end

def get_hash val
 (Digest::SHA256.new << (val + Rails.application.config.secret_key_base)).to_s
end
  