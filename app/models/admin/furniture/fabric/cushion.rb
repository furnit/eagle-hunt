class Admin::Furniture::Fabric::Cushion < ApplicationRecord
  
  validates_presence_of :label, :height, :width
  validate :validate_numerics
  validates_uniqueness_of :label
  validates_uniqueness_of :height, scope: :width
  
  protected
  
    def validate_numerics
      [:width, :height].each do |col|
        if not(self[col] and self[col].to_s.numeric? and self[col].to_f > 0)
          errors.add col, :invalid
        end
      end
    end
end
