class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
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
end
