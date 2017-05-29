class Admin::Selling::Config::DaysToComplete < ApplicationRecord
  validates_presence_of :extra
  validates_numericality_of :extra, greater_than_or_equal_to: 0
end
