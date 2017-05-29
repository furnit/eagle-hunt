class Admin::Selling::Config::PiecePrice < ApplicationRecord
  belongs_to :set, class_name: '::Admin::Furniture::Set', foreign_key: :admin_furniture_set_id
  belongs_to :piece, class_name: '::Admin::Furniture::Piece', foreign_key: :admin_furniture_piece_id
  
  validates_presence_of  :percentage, :set, :piece
  validates_inclusion_of :percentage, in: 0..1
  
  validate :same_set
  
  def admin_furniture_set_id= val
    # prevent from mistakes
    self[:admin_furniture_set_id] = Admin::Furniture::Set.prefered.id
  end
  
  def same_set
    # check to make sure all table has same prefered sets' ID
    # `.reload` is required due to test {commit@3cba486}
    if not self.set or self.set.reload.total_count != AppConfig.preference.furniture.unit
      errors.add :admin_furniture_set_id, :invalid
    end
  end
end
