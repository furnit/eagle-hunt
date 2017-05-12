module ApplicationHelper
  def two_step_auth
    ::TwoStepAuth.new current_user
  end
  
  def editable_tag instance, field, **kwargs
    text = (kwargs[:text] || eval("instance.#{field.to_s}")).to_s
    kwargs.delete :text
    klass = "editable #{kwargs[:class]}"
    if not kwargs[:enabled]
      klass += " editable-click editable-disabled"
    else
      kwargs.delete :enabled
    end
    kwargs.delete :class
    
    link_to text, "#", class: klass, data: { 
      type: :text,
      resource: "#{instance.model_name.param_key}", 
      name: field.to_s.downcase, 
      url: path_exists?("#{instance.model_name.singular_route_key}_path(id: -1)") ? send("#{instance.model_name.singular_route_key}_path", instance, format: :json) : nil,
      "original-title": kwargs[:"original-title"] || text
    }.merge(kwargs)
    
  end
  
  def list_or_prompt(k, p, &block)
    concat sanitize "<div class='empty-collection'>%s</div>" %p if k.empty?
    k.each.with_index { |l, index| yield l, index }
  end
  
  def namespace? sym
    split = params[:controller].split('/')
    split.length > 1 and split[0].downcase == sym.to_s.downcase
  end
  
  def recaptcha_tag callback: nil, has_error: false
    raw "<div class='form-group %s'>
      <label class='control-label'>لطفا جهت احراز هویت گزینه‌ی «من ربات نیستم» را انتخاب کنید.</label>
      <div class='g-recaptcha' data-sitekey='#{AppConfig.recaptcha.keys.site}' %s></div>
     </div>" %[(has_error ? 'has-error' : ''), (callback.blank? ? '' : "data-callback='#{callback}'")]
  end
   
  def path_exists? path
    begin
      eval(path)
    rescue NameError
      return false
    end
    
    return true
  end
  
  def render_two_step_auth_form name: nil
    name ||= ::TwoStepAuth.input_name
    @temp_password_id ||= 0
    @temp_password_id +=  1
    link = link_to send_two_step_auth_token_admin_users_path(format: :json), method: :post, remote: true, class: "btn btn-default", id: "request_temp_pass_token#{@temp_password_id}" do
        raw "<span class='fa fa-key'></span> ارسال رمز موقت"
    end
    raw "<table class='table nolayout' id='#{name}-template'>
        <tbody>
          <tr>
            <td class='ir col-md-5'>
              <div class='input-group'>
                <input type='text' name='#{name}' class='form-control' placeholder='رمز موقت'>
                <span class='input-group-btn'>#{link}</span>
              </div>
            </td>
            <td style='vertical-align: middle'>
              <div id='request_temp_pass_token_result#{@temp_password_id}' class='col-md-5 pull-right'></div>
            </td>
          </tr>
        </tbody>
      </table>
      <script type='text/javascript' charset='utf-8'>
        $(document).ready(function(){
          $('a#request_temp_pass_token#{@temp_password_id}').on('ajax:beforeSend', function() {
            if($(this).data('origin-html') === undefined)
              $(this).data('origin-html', $(this).html());
            $(this).addClass('disabled').html('<span class=\"fa fa-spinner fa-spin\"></span>');
          }).on('ajax:success', function(e, data) {
            if(data.status === 'sent')
              $('#request_temp_pass_token_result#{@temp_password_id}').html('<span class=\"label label-success\">پیامک حاوی رمز موقت ارسال شد.</span>').removeClass('hidden');
            else
              $('#request_temp_pass_token_result#{@temp_password_id}').html('<span class=\"label label-danger\">خطا در ارسال رمز موقت.</span>').removeClass('hidden');
          }).on('ajax:error', function(){
            $('#request_temp_pass_token_result#{@temp_password_id}').html('<span class=\"label label-danger\">خطا در ارسال رمز موقت.</span>').removeClass('hidden');
          }).on('ajax:complete', function(){
            $(this).blur();
            $(this).removeClass('disabled').html($(this).data('origin-html'));
          });
        });
      </script>"
  end
  
  def get_namespace
    split = params["controller"].split('/')
    return :default if split.length == 1
    return split[0].to_sym
  end

  def create_cover(image, **args)
    height = args[:height] || '350px'
    width = args[:width] || '100%'
    css_class = args[:class] || ''
    css_id = args[:id] || ''
    css_style = args[:style] || ''
    thumb = args[:thumb] || ''
    raw '<div class="img img-responsive %s" id="%s" style="%s;width:%s;height:%s;background-image:url(%s);background-repeat:no-repeat;" data-thumb="%s"></div>' %[css_class.to_s, css_id.to_s, css_style.to_s, width.to_s, height.to_s, image.to_s, thumb.to_s]
  end

  def check_awesome(title, comment, checked: false, id: nil, name: nil, value: nil, box_title: '', prefix: '')
    @check_awesome_id ||= 0
    @check_awesome_id += 1
    id = id || 'check-awesome-id' + @check_awesome_id.to_s
    raw "<div class='check-awesome form-group ir'>
      <input type='checkbox' id='#{prefix}#{id}' %s %s %s>
      <label for='#{prefix}#{id}'>
        <span></span>
        <span class='check'></span>
        <span class='box' title='#{box_title}' data-toggle='tooltip'></span>
        <msg class='title'>#{title}</msg>
      </label>
      <p class='text-justify'>#{comment}</p>
    </div>" %[name ? "name='#{name}'" : '', checked ? 'checked=checked' : '', value ? "value='#{value}'" : '']
  end

  def i18n_set?(key)
    I18n.t key, :raise => true rescue false
  end

  def define_path_to_here!(*args)
    args = args.flatten
    str = "<ol class='breadcrumb col-md-12' style='font-weight: bold; background-color: white; border: 1px solid #eee; border-radius: 0; marginx: auto 20px 30px 20px;'>
            <li><span class='fa fa-angle-double-left' style='margin-left: 10px'></span>#{link_to 'مبل ویرا', root_path}</li>"
    args.each.with_index do |l, index|
      link = "#{l[:label]}"
      link = "<a href='#{l[:href]}'>#{link}</a>" if l[:href]
      str += "<li" + (index != args.length - 1 ? "" : " class='active'") + ">#{link}</li>"
    end
    str += "</ol>"
    return raw str
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

  def redirect_form(instance, **args)
    bootstrap_form_for instance, **args, :html => { :name => instance.class.name.split('::').last.underscore } do |f|
      yield f
    end
  end
  def remote_form(instance, **args)
    args[:remote] = true
    args[:format] = :json
    redirect_form(instance, args) { |f| yield f }
  end
end