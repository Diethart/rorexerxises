FactoryGirl.define do
  factory :card do
    original_text   'text'
    translated_text 'text2'
    user_id '1'
    review_date     Date.today
  end
  factory :user do
    email 'someemail@gmail.com'
    password '1111'
  end
end

