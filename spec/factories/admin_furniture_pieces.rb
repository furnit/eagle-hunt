FactoryGirl.define do
  factory :admin_furniture_piece, class: 'Admin::Furniture::Piece' do
    piece { 10 + rand * 10 }
    comment { generate :text }
  end
end
