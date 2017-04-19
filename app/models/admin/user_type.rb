class Admin::UserType < ApplicationRecord

  validates_presence_of :name, :symbol, :auth_level

  validates :name, :symbol, uniqueness: true

  has_many :users, foreign_key: :admin_user_type_id

end
