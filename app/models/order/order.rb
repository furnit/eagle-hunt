class Order::Order < ApplicationRecord
  belongs_to :user
  belongs_to :state, class_name: '::State', foreign_key: :state_id
  belongs_to :default, class_name: '::Admin::UploadedFile', foreign_key: :default_id
  belongs_to :furniture, class_name: '::Admin::Furniture::Furniture', foreign_key: :admin_furniture_furniture_id
  has_one    :payment, class_name: '::Admin::Selling::Order::Payment', foreign_key: :order_order_id
end
