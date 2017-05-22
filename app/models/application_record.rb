class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  after_validation do
    # unify the error message
    collection = { }
    self.errors.messages.each do |field, msgs|
      collection[field] ||= []
      msgs.each.with_index do |msg, index|
        self.errors.messages[field].delete_at index if collection[field].include? msg
      end
    end
  end
  
  protected
  
  def normalize_phone_number number
    return number if number.nil? or number.blank?
    out = number.to_s.gsub(/[- ,.]+/, "")
    return number if not out.to_s.numeric?
    out
  end

  def helper
    @helper ||= Class.new do
      # include `number_to_phone`
      include ActionView::Helpers::NumberHelper
    end.new
  end
  
  def error_messages!
    return "" unless error_messages?
    
    plurize_verb = self.errors.count > 1 ? 'ند' : '' 
    
    html = <<-HTML
    <div id="error_explanation" class="panel panel-danger">
      <div class="panel-heading">#{self.errors.count} عدد خطا مانع ذخیره‌سازی داده‌ها شد#{plurize_verb}.</div>
      <div class="panel-body">
        <ol class=''>
    HTML
    
    self.errors.full_messages.each do |message|
      html += "<li>#{message}</li>"
    end
    
    html += <<-HTML
        </ol>
      </div>
    </div>
    HTML

    html.html_safe
  end
  
  def error_messages?
    self.errors.any?
  end
  
  scope :select_except, lambda { |*columns| select(column_names - columns.map(&:to_s)) }
end
