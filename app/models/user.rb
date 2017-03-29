class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_one :profile
  belongs_to :user_type, class_name: 'Admin::UserType', foreign_key: :admin_user_type_id

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
