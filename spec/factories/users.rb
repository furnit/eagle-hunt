FactoryGirl.define do
  factory :user do
    email
    phone_number
    after(:build) { |u| u.password = u.password_confirmation = generate(:password) }

    factory :admin_user do
      type { Admin::UserType.find_by_symbol(:ADMIN) }
    end

    factory :client_user do end
  end
end
