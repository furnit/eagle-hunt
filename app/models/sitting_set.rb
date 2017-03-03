class SittingSet < ApplicationRecord
  has_many :furniture, through: :furniture_sets
end
