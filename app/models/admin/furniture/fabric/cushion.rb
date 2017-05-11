class Admin::Furniture::Fabric::Cushion < ApplicationRecord
  
  validates_presence_of :label, :height, :width

  validate :validate_numerics
  
  protected
  
  def validate_numerics
    [:width, :height].each do |col|
      if not(self[col] and self[col].to_s.numeric? and Float(self[col].to_s) >= 30)
        errors.add col, I18n.t("activerecord.errors.models.#{self.model_name.i18n_key}.attributes.#{col}.invalid") if self[col]
      end
    end
  end

end
