FactoryBot.define do
  factory :newsletter do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    publish_at { Time.now + 10.minutes }
    scheduled { false }
  end
end
