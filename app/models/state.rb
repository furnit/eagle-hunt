class State < ApplicationRecord  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.all
    Rails.cache.fetch("all_states", expires_in: 1.months) do
      super
    end
  end
end
