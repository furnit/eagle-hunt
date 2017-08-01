FactoryGirl.define do
  factory :admin_furniture_set, class: 'Admin::Furniture::Set' do
    after(:build) do |set|
      set.config.each do |s|
        # going for `.save` to prevent from having
        # `ActiveRecord::RecordInvalid` error on `create` for duplicate `#piece`
        (build :admin_furniture_piece, piece: s).save
      end
    end

    name { generate :string }
    comment { generate :text }
    config { [10, 10, 20, 30] }
  end
end
