class Admin::Selling::Payment::Payment < ApplicationRecord
  belongs_to :order/order
end
