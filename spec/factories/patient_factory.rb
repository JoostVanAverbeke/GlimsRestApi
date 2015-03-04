require 'factory_girl'
require 'faker'
require 'faker_extensions'

FactoryGirl.define do
  factory :random_patient, class: 'Patient' do
    surname { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    birth_date { Faker::Date.dob }
  end
end