class Admin::Selling::Order::Payment < ApplicationRecord
  belongs_to :order, class_name: '::Order::Order', foreign_key: :order_order_id

  def amount
    self[:amount].to_i
  end
end
