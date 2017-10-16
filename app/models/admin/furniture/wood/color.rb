class Admin::Furniture::Wood::Color < ApplicationRecord
  validates_presence_of :name, :value
  validates_uniqueness_of :name, :value
  validates_format_of :value, with: /\A#?([0-9A-F]{3})?[0-9A-F]{3}\z/i

  def value= val
    if val.nil?
      self[:value] = nil
    else
      self[:value] = val.to_s.gsub "#", ""
    end
  end
end
