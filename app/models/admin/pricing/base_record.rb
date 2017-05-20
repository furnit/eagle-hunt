class Admin::Pricing::BaseRecord < ApplicationRecord
  self.abstract_class = true
  
  protected

  validate :validate_prices
  
  def validate_prices
    ls_numeric_attribs.each do |col|
      if self[col]
        if not(self[col].to_s.numeric? and Float(self[col]) >= 0 and Float(self[col]) <= 1_000_000_000)
          errors.add col, I18n.t("activerecord.errors.models.#{self.model_name.i18n_key}.attributes.#{col}.invalid")
        end
      end
    end
  end
  
  def prepare_price_fields
    ls_numeric_attribs.each do |col|
      self.class.send :define_method, "#{col}=" do |val|
        self[col] = val.to_s.gsub(/[, ]/, "")
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
