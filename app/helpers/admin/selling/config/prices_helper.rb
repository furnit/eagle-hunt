module Admin::Selling::Config::PricesHelper
  def build_price_select form, prices, name, target, label: "", prompt: "", required: false
    required = "required" if required 
    name = "#{form.object_name}[#{name}]"
    out  = "<div class='form-group'>"
    out += "<label for='#{name}'>#{label}</label>"
    out += "<select class='selectpicker' data-live-search='true' data-show-subtext='true' name='#{name}' #{required}>"
    out += "<option value=''>#{prompt}</option>" if not prompt.blank?
    prices.each do |p|
      out += "<option value='#{eval("p.#{target.to_s}.id")}' data-subtext='#{p.price} تومان'>#{eval("p.#{target.to_s}.name")}</option>"
    end
    out += "</select></div>"
    raw out
  end
end
