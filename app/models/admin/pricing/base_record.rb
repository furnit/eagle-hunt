class Admin::Pricing::BaseRecord < ApplicationRecord
  self.abstract_class = true
  
  validate :validate_numerics
  
  protected
  
  def validate_numerics
    ls_numeric_attribs.each do |col|
      if not(self[col] and self[col].to_s.numeric? and Float(self[col]) >= 0)
        errors.add col, I18n.t("activerecord.errors.models.#{self.model_name.i18n_key}.attributes.#{col}.invalid")
      end
    end
  end
  
  def ls_numeric_attribs
    cols = []
    klass = self.class.name.classify.constantize;
    attribs = klass.attribute_names.reject { |attr| attr =~ /id|created_at|updated_at/i }
    klass.columns.each do |col|
      next if not attribs.include? col.name
      if [:float, :integer, :decimal].include? col.type
        cols << col.name.to_sym
      end
    end
    cols
  end
  
end
