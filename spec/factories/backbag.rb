FactoryGirl.define do
  sequence :string do |n|
    ((0..9).map { ('a'..'z').to_a[rand(26)] }.join + n.to_s)
  end
  sequence :text do |n|
    Faker::Lorem.paragraphs(3).join("[#{n.to_s}]. ")
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
  sequence :hex_color do |n|
    "##{format('%06d', n)}"
  end
end