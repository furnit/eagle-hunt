FactoryGirl.define do
  factory :admin_selling_config_piece_price, class: 'Admin::Selling::Config::PiecePrice' do
    association :piece, factory: :admin_furniture_piece
    set { Admin::Furniture::Set.first || association(:admin_furniture_set) }
    percentage { rand }
    comment { generate :text }
  end
end
