FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password "passwordislong"

    trait :admin do
      admin true
    end
  end
end
