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
    concat sanitize "<div class='empty-collection'>%s</div>" %p if k.empty?  
    k.each { |l| yield l }
  end
  
  def create_cover(image, **args)
    height = args[:height] || '350px'
    width = args[:width] || '100%'
    css_class = args[:class] || ''
    css_id = args[:id] || ''
    css_style = args[:style] || ''
    raw '<div class="img img-responsive img-thumbnail %s" id="%s" style="%s;width:%s;height:%s;background-image:url(%s);background-size:cover;background-repeat:no-repeat;background-position: center center"></div>' %[css_class.to_s, css_id.to_s, css_style.to_s, width.to_s, height.to_s, image.to_s]
  end
  def check_awesome(title, comment, name = 'check-me')
      raw "<div class='check-awesome form-group ir'>    
        <input type='checkbox' id='#{name}' name='#{name}'>
        <label for='#{name}'>
          <span></span>
          <span class='check'></span>
          <span class='box'></span>
          #{title}
        </label>  
        <p class='text-justify'>#{comment}</p>
      </div>"
  end
end