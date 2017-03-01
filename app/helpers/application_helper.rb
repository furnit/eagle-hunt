module ApplicationHelper
  def auth_is?(*k)
    return false if not user_signed_in?
    k.each do |t| 
      return true if current_user.auth_level == AUTH_LEVEL[t]
    end
    return false
  end
  
  def auth_for(*k, &block)
    if auth_is? *k
      yield
    end
  end
  
  def list_or_prompt(k, p, &block)
    return raw "<div class='empty-collection'>%s</div>" %p if k.empty?  
    k.each { |l| yield l }
  end
end