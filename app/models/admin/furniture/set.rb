class Admin::Furniture::Set < ApplicationRecord
  SEPERATOR = "-, ،_\\[\\]"
  
  validates_presence_of :name, :config, :comment
  validate :validate_config
  validate :validate_uniqueness_config
  
  before_save { self[:config] = self.config }
  
  def config= val
    self[:config] = val.to_s.split(/[#{SEPERATOR}]+/).flatten.reject { |s| s.empty? }
    self[:total_count] = self[:config].map(&:to_i).sum
  end
  
  def config
    (self[:config] || []).map(&:to_i).sort
  end
  
  def total_count= val
    # prevent from mistake settings
  end
  
  def validate_config
    pieces = Admin::Furniture::Piece.pluck(:piece)
    (self[:config] || []).each do |i|
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
    ids = (self[:config] || [])
    self.class.where.not(id: id).where(total_count: total_count).pluck(:config).each do |_config|
      if _config.sort == config.sort
        errors.add :config, :taken
        break
      end
    end
  end
  
  def self.prefered
    Admin::Furniture::Set.find_by(total_count: AppConfig.preference.furniture.unit)
  end

end
