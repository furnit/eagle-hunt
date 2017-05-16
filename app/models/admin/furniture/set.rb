class Admin::Furniture::Set < ApplicationRecord
  SEPERATOR = "-, ،_"
  
  validates_presence_of :name, :config
  validate :validate_config
  validate :validate_uniqueness_config
  before_save { self.config = self.config.map { |i| i.to_s.to_i } }
  
  def config= val
    self[:config] = val.split(/[#{SEPERATOR}]+/).flatten
    self[:total_count] = self[:config].map(&:to_i).sum
  end
  
  def total_count= val
    # prevent from mistake settings
  end
  
  def validate_config
    pieces = Admin::Furniture::Piece.pluck(:piece)
    config.each do |i|
      if not i.to_s.numeric?
        errors.add :config, :invalid 
        break
      end
      if not pieces.include? i.to_s.to_i
        errors.add :config, :not_defined
        break
      end
    end
  end
  
  def validate_uniqueness_config
    if self.class.where.not(id: id).where("config REGEXP ?", ".*#{config.map { |i| i.to_s.to_i }.to_s[1..-2]}.*").count > 0
      errors.add :config, :taken
    end
  end
  
  def self.prefered
    Rails.cache.fetch('prefered_set', expires_in: 1.months) do
      Admin::Furniture::Set.find_by(total_count: AppConfig.preference.furniture.unit)
    end
  end

end
