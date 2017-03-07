class Profile < ApplicationRecord
  belongs_to :user
  validates_presence_of :first_name, :last_name, :contact, :address
  
   validates_format_of :contact, :with => /09\d{2}[- ]?\d{3}[- ]?\d{4}/i
   
   before_save :normalize_contact_number
 
private

  def normalize_contact_number
    self.contact = helper.number_to_phone(self.contact)
  end

  def helper
    @helper ||= Class.new do
      # include `number_to_phone`
      include ActionView::Helpers::NumberHelper
    end.new
  end
end
