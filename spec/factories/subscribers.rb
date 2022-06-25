FactoryBot.define do
  factory :subscriber do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    source { Subscriber.sources.keys.first }
    confirmation_token { Faker::Lorem.word }
    confirmed_at { Time.now }
    confirmation_sent_at { Time.now }
  end
end
