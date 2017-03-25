module ApplicationHelper
  def auth_is?(*k)
    return false if not user_signed_in?
    k.each do |t| 
      return true if current_user.auth_level == AUTH_LEVEL[t]
    end
    return false
  end
  
  def auth_for(*k, &block)
    if auth_is?(*k)
      yield
    end
  end
  
  def list_or_prompt(k, p, &block)
    concat sanitize "<div class='empty-collection'>%s</div>" %p if k.empty?  
    k.each.with_index { |l, index| yield l, index }
  end
  
  def create_cover(image, **args)
    height = args[:height] || '350px'
    width = args[:width] || '100%'
    css_class = args[:class] || ''
    css_id = args[:id] || ''
    css_style = args[:style] || ''
    raw '<div class="img img-responsive img-thumbnail %s" id="%s" style="%s;width:%s;height:%s;background-image:url(%s);background-repeat:no-repeat;background-position: center center"></div>' %[css_class.to_s, css_id.to_s, css_style.to_s, width.to_s, height.to_s, image.to_s]
  end
  
  def check_awesome(title, comment, checked: false, id: nil, name: nil, value: nil, prefix: '')
    @check_awesome_id ||= 0
    @check_awesome_id += 1
    id = id || 'check-awesome-id' + @check_awesome_id.to_s
    raw "<div class='check-awesome form-group ir'>    
      <input type='checkbox' id='#{prefix}#{id}' %s %s %s>
      <label for='#{prefix}#{id}'>
        <span></span>
        <span class='check'></span>
        <span class='box'></span>
        <msg class='title'>#{title}</msg>
      </label>  
      <p class='text-justify'>#{comment}</p>
    </div>" %[name ? "name='#{name}'" : '', checked ? 'checked=checked' : '', value ? "value='#{value}'" : '']
  end
  
  def i18n_set?(key)
    I18n.t key, :raise => true rescue false
  end
  
  def path_to_here!(*_pathes)
    pathes = [link_to(t('routes.%s.label' %controller.controller_name), request.path)]

    if i18n_set? ('routes.%s.%s' %[controller.controller_name, controller.action_name])
      pathes << t('routes.%s.%s' %[controller.controller_name, controller.action_name])
    elsif i18n_set? ('routes.%s' %[controller.action_name])
      pathes << t('routes.%s' %[controller.action_name])
    elsif _pathes.length ==  0
      pathes = [t('routes.%s.label' %controller.controller_name)]
    end
      
    pathes += _pathes if _pathes.length
    
    str = "<ol class='breadcrumb col-md-12' style='font-weight: bold; background-color: white; border: 1px solid #eee; border-radius: 0; marginx: auto 20px 30px 20px;'>
            <li><span class='fa fa-angle-double-left' style='margin-left: 10px'></span>#{link_to 'مبل ویرا', root_path}</li>"
    pathes.each.with_index do |l, index|
      str += "<li" + (index != pathes.length - 1 ? "" : " class='active'") + "> #{l}</li>"
    end
    str += "</ol>"
    return raw str
  end
  
  def shopping_cart_count?
    return ShoppingCart.where("user_id = ?", current_user.id).count if user_signed_in?
    return session[:shopping_cart].length if session[:shopping_cart]
    return 0
  end
  
  def redirect_form(instance)
    bootstrap_form_for instance, :html => { :name => instance.class.name.split('::').last.underscore } do |f|
      yield f
    end
  end
  def remote_form(instance)
    bootstrap_form_for instance, :remote => true, :html => { :'data-type' => 'json',  :name => instance.class.name.split('::').last.underscore } do |f|
      yield f
    end
  end
end