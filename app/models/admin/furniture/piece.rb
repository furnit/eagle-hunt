class Admin::Furniture::Piece < ApplicationRecord
  validates_presence_of :piece, :comment
  validates_numericality_of :piece, greater_than: 0
  validates_uniqueness_of :piece
end
