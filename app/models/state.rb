class State < ApplicationRecord
  def self.all
    Rails.cache.fetch("all_states", expires_in: 1.months) do
      super
    end
  end
end
