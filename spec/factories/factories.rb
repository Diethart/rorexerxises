FactoryGirl.define do

  factory :authentication do
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :name do |n|
    "test_deck#{n}"
  end

  factory :deck do
    user
    name
  end

  factory :user do
    email
    password '1111'
    password_confirmation '1111'
  end

  factory :card do
    user
    deck
    original_text   'text'
    translated_text 'text2'
    review_date     DateTime.now.beginning_of_hour
  end

end
