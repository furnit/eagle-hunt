class Admin::Selling::Config::DaysToComplete < ApplicationRecord
  validates_numericality_of :extra, only_integer: true, greater_than_or_equal_to: 0
end
