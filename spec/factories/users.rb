FactoryGirl.define do
  factory :user do
    email
    phone_number
    after(:build) { |u| u.password = u.password_confirmation = generate(:password) }    
  end
end
