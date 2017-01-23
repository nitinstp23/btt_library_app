FactoryGirl.define do

  factory :book_issue do
    book
    consumer { create(:consumer, email: Faker::Internet.email) }
    issued_at Faker::Date.backward(1)
    due_date  Faker::Date.forward(4)
  end

end
