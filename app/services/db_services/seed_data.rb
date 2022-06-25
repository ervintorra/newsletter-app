require 'faker'

module DbServices
  class SeedData < BaseService
    def initialize; end

    def execute
      Rails.logger.info 'Seeding data...'

      seed_user
      seed_subscribers
      seed_newsletters
      success_response
    end

    private

    def seed_user
      Rails.logger.info 'Seeding user...'
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'ervintorra@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      )

      user.skip_confirmation!
      user.save!
    end

    def seed_newsletters
      Rails.logger.info 'Seeding newsletters...'
      user = User.first

      1.upto(10) do |_i|
        user.newsletters.create!(
          title: Faker::Lorem.sentence,
          body: Faker::Lorem.paragraph,
          publish_at: Time.now + rand(6...10).minutes
        )
      end
    end

    def seed_subscribers
      Rails.logger.info 'Seeding subscribers...'

      1.upto(100) do |_i|
        subscriber = Subscriber.new(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          source: Subscriber.sources[rand(2)],
          confirmed_at: Time.now
        )
        subscriber.skip_confirmation!
        subscriber.save!
      end
    end
  end
end
