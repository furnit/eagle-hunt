class Order::Order < ApplicationRecord
  belongs_to :user
  belongs_to :furniture, class_name: '::Admin::Furniture::Furniture', foreign_key: :admin_furniture_furniture
  belongs_to :default, class_name: '::Admin::UploadedFile', foreign_key: :default_id
end
