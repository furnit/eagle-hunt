FactoryGirl.define do
  sequence :string do |n|
    ((0..9).map { ('a'..'z').to_a[rand(26)] }.join + n.to_s)
  end
  sequence :text do |n|
    (Faker::Lorem.paragraph + n.to_s)
  end
  sequence :first_name do |n|
    "first_name#{n}"
  end
  sequence :last_name do |n|
    "last_name#{n}"
  end
  sequence :email do |n|
    "email#{n}@example.com"
  end
  sequence :password do |_|
    "password"
  end
  sequence :phone_number do |n|
    "0#{(9120000000 + n)}"
  end
end