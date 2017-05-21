class Admin::UserType < ApplicationRecord
  has_many :users, foreign_key: :admin_user_type_id

  validates_presence_of :name, :comment, :symbol, :auth_level
  validates :name, :symbol, uniqueness: true
  validates_numericality_of :auth_level, greater_than_or_equal_to: 0
end
