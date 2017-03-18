class ParanoiaRecord < ApplicationRecord
  self.abstract_class = true
  
  # to make `acts_as_paranoid` accesable to the child classes
  def self.inherited(base)
      base.acts_as_paranoid
      super
  end
end
