FactoryGirl.define do

  factory :book do
    title    Faker::Book.title
    author   Faker::Book.author
    sequence :isbn do |n|
      "#{Faker::Lorem.word}-ISBN-#{n}"
    end
    quantity Faker::Number.number(2)
  end

end
