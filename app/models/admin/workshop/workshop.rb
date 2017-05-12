class Admin::Workshop::Workshop < ApplicationRecord
  belongs_to :state
  belongs_to :manager, class_name: '::User', foreign_key: :user_id
  
  has_many :transits, class_name: '::Admin::Pricing::Transit', foreign_key: :admin_workshop_workshop_id
  
  validates_presence_of :name, :address, :phone_number, :user_id, :state_id
  validates_uniqueness_of :name
  
  validates :phone_number, length: { is: 11 }, uniqueness: true
  validates_format_of :phone_number, :with => /0\d{3}[- ]?\d{3}[- ]?\d{4}/i

  before_validation :normalize_phone_number
  after_initialize :normalize_phone_number
  after_validation {
    # remove one of errors `wrong_length` and `invalid` if both occures at same time.
    if (self.errors.details[:phone_number].map { |e| e[:error] } & [:invalid, :wrong_length]).length == 2
      self.errors.messages[:phone_number].delete_at self.errors.details[:phone_number].index { |i| i[:error] == :wrong_length }
    end
  }
  
  def normalize_phone_number
    return self.phone_number if self.phone_number.nil?
    self.phone_number = helper.number_to_phone(self.phone_number.strip, delimiter: "", pattern: /(\d{4})[- ]?(\d{3})[- ]?(\d{4})$/)
  end
  
  def helper
    @helper ||= Class.new do
      # include `number_to_phone`
      include ActionView::Helpers::NumberHelper
    end.new
  end  
end
