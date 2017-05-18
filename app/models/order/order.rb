class Order::Order < ApplicationRecord
  belongs_to :user
  belongs_to :admin_furniture_furniture
  belongs_to :fabric
  belongs_to :admin_furniture_paint_color
  belongs_to :admin_furniture_wood_types
end
