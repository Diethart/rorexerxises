FactoryGirl.define do
  factory :card do
    original_text   'text'
    translated_text 'text2'
    review_date     Date.today
  end
end

