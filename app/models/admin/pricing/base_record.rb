class Admin::Pricing::BaseRecord < ApplicationRecord
  self.abstract_class = true
  
  protected
 
  validate :validate_prices
  
  def validate_prices
    ls_numeric_attribs.each do |col|
      if self[col] and @error_container[col]
        errors.add col, @error_container[col]
      end
    end
  end
  
  def prepare_price_fields
    ls_numeric_attribs.each do |col|
      self.class.send :define_method, "#{col}=" do |val|
        @error_container ||= { }
        val = val.to_s.gsub(/[, ]/, "")
        if not(val.numeric? and Float(val) >= 0 and Float(val) <= 1_000_000_000)
          @error_container[col] = :invalid 
        else
          @error_container.delete col
        end
        self[col] = val
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
