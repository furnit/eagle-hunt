FactoryGirl.define do
  factory :profile do
    association :user, factory: :user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { "تهران، خیابان ولیعصر" }
    postal_code { rand.to_s[2..11] }
    state_id { State.order("RAND()").first.id }
  end
end
