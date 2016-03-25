FactoryGirl.define do

  factory :user do
    email 'someemail@gmail.com'
    password '1111'
  end

  factory :card do
    original_text   'text'
    translated_text 'text2'
    user
    review_date     Date.today
  end

end

