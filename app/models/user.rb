class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_one :profile, autosave: true
  belongs_to :user_type, class_name: 'Admin::UserType', foreign_key: :admin_user_type_id

  validates_format_of :phone_number, :with => /09\d{2}[- ]?\d{3}[- ]?\d{4}/i

  before_validation :normalize_phone_number
  after_initialize :normalize_phone_number

  before_save :check_if_password_changed?

  def helper
    @helper ||= Class.new do
      # include `number_to_phone`
      include ActionView::Helpers::NumberHelper
    end.new
  end

  def normalize_phone_number
    self.phone_number = self.phone_number.to_ar2en_i;
    self.phone_number = helper.number_to_phone(self.phone_number.strip, delimiter: "", pattern: /(\d{4})[- ]?(\d{3})[- ]?(\d{4})$/)
  end

  def self.authenticate(phone_number, password, with_deleted = "with_deleted")
    user = eval("User.#{with_deleted}.find_for_authentication(:phone_number => '#{phone_number}')")
    user and user.valid_password?(password) ? user : nil
  end

  def check_if_password_changed?
    self.change_password = false if self.change_password and self.encrypted_password_changed?
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
