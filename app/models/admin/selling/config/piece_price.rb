class Admin::Selling::Config::PiecePrice < ApplicationRecord
  belongs_to :set, class_name: '::Admin::Furniture::Set', foreign_key: :admin_furniture_set_id
  belongs_to :piece, class_name: '::Admin::Furniture::Piece', foreign_key: :admin_furniture_piece_id
  
  validates_inclusion_of :percentage, :in => 0..1
  
end
