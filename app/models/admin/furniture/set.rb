class Admin::Furniture::Set < ApplicationRecord
  SEPERATOR = "-, ،_"
  
  validates_presence_of :name, :config
  validate :validate_config
  validate :validate_uniqueness_config
  before_save { self.config = self.config.map { |i| i.to_s.to_i } }
  
  def config= val
    self[:config] = val.split(/[#{SEPERATOR}]+/).flatten
  end
  
  def validate_config
    config.each do |i|
      if not i.to_s.numeric?
        errors.add :config, :invalid 
        break
      end 
    end
  end
  
  def validate_uniqueness_config
    if self.class.where.not(id: id).where("config REGEXP ?", ".*#{config.map { |i| i.to_s.to_i }.to_s[1..-2]}.*").count > 0
      errors.add :config, :taken
    end
  end
end
