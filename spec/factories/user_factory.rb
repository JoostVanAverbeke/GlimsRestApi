FactoryGirl.define do
  factory :user do
    email "john.doe@gmail.com"
    password "1234_password"

# => Create a nested factory :sequenced_user
    factory :sequenced_user do
      sequence(:email) {|n| "john.doe#{n}@gmail.com" }
    end
  end
end