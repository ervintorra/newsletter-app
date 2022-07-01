module JobServices
  class ScheduleNextNewslettersInRow < BaseService
    TIME_RANGE_CHECKING = Time.current...Time.current + Newsletter::TIME_RANGE_TOLERANCE
    BATCH_SIZE = 100

    def initialize
      @newsletters_to_be_scheduled = Newsletter.where(publish_at: TIME_RANGE_CHECKING)
                                               .unscheduled
                                               .order(:publish_at)
                                               .to_a
    end

    def execute
      return success_response if @newsletters_to_be_scheduled.empty?

      display_logs
      scheduler = initialize_scheduler

      @newsletters_to_be_scheduled.each do |newsletter|
        scheduler.increment_end_time_on_new_time(newsletter.publish_at)

        Subscriber.confirmed.find_in_batches(batch_size: BATCH_SIZE) do |group|
          group.each do |subscriber|
            NewsletterMailer.send_newsletter(newsletter.id, subscriber.id).deliver_later(wait_until: scheduler.end_time)
            scheduler.increment
          end
        end

        newsletter.schedule
      end

      set_end_time_to_redis(scheduler.end_time)
      success_response
    rescue StandardError => e
      Rails.logger.error "Failed to schedule newsletters: #{e.message}"
      unsuccess_response
    end

    private

    def initialize_scheduler
      end_time_from_redis = Rails.cache.redis.get('time_scheduler_end_time')
      first_newsletter_publish_at = @newsletters_to_be_scheduled[0].publish_at

      end_time = if end_time_from_redis.present?
                   first_newsletter_publish_at.to_s < end_time_from_redis ? end_time_from_redis : first_newsletter_publish_at
                 else
                   first_newsletter_publish_at
                 end

      TimeScheduler.new(end_time, end_time)
    end

    def set_end_time_to_redis(end_time)
      Rails.cache.redis.set('time_scheduler_end_time', end_time.to_s, ex: 1.hour)
    end

    def display_logs
      subscribers = Subscriber.count
      Rails.logger.info "Found #{@newsletters_to_be_scheduled.size} newsletters to be scheduled and delivered to #{subscribers} subscribers."
    end
  end
end


