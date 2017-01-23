FactoryGirl.define do

  factory :admin_user do
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    sequence :email do |n|
      "#{n}+#{Faker::Internet.email}"
    end
    password   Faker::Internet.password(8)
  end

end
