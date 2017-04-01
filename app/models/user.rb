class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_one :profile

  belongs_to :user_type, class_name: 'Admin::UserType', foreign_key: :admin_user_type_id

  validates_format_of :phone_number, :with => /09\d{2}[- ]?\d{3}[- ]?\d{4}/i

  before_save { self.phone_number = helper.number_to_phone(self.phone_number.strip, delimiter: "", pattern: /(\d{4})[- ]?(\d{3})[- ]?(\d{4})$/) }

  def helper
    @helper ||= Class.new do
      # include `number_to_phone`
      include ActionView::Helpers::NumberHelper
    end.new
  end

	def email_required?
    false
  end

  def email_changed?
    false
  end

  def full_name
    return 'بدون نام' if self.profile == nil
    '%s %s' %[self.profile.first_name, self.profile.last_name]
  end
end
