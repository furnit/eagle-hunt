class Order < ApplicationRecord
  belongs_to :user
  belongs_to :furniture
  belongs_to :parche_colour
  belongs_to :parche_design
  belongs_to :kande_colour
end
