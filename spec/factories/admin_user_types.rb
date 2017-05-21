FactoryGirl.define do
  factory :admin_user_type, class: 'Admin::UserType' do
    name { generate :string }
    comment { generate :text }
    symbol { generate(:string).to_sym }
    auth_level 1
  end
end
