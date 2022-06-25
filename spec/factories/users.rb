FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    # role { 'user' }
    password { '123456' }
    password_confirmation { '123456' }
    confirmed_at { Date.today }
  end
end
