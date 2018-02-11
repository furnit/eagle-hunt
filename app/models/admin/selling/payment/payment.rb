class Admin::Selling::Payment::Payment < ApplicationRecord
  belongs_to :order, class_name: '::Order::Order', foreign_key: :order_order_id
end
