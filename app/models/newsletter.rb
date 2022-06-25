class Newsletter < ApplicationRecord
  TIME_RANGE_TOLERANCE = 5.minutes
  MINIMUM_TIME_TO_SCHEDULE_NEWSLETTER = Time.current + (TIME_RANGE_TOLERANCE + 1.minute)

  belongs_to :user

  validates :publish_at, comparison: { greater_than: MINIMUM_TIME_TO_SCHEDULE_NEWSLETTER },
                         if: -> { publish_at.to_s != publish_at_was.to_s }
  validates :title, presence: true
  validates :body, presence: true

  scope :undelivered, lambda {
    where(delivered: false)
  }

  scope :unscheduled, lambda {
    where(scheduled: false)
  }

  scope :publish_in_future, lambda {
    where('publish_at > ?', Time.now)
  }

  def deliver
    self.delivered = true
    save(validate: false)
  end

  def schedule
    self.scheduled = true
    save(validate: false)
  end

  def delivered?
    delivered == true
  end

  def scheduled?
    scheduled == true
  end

  def publish_in_future?
    publish_at >= Time.current
  end

  def not_rescheduled?
    publish_at <= Time.current
  end

  def ready_to_publish?
    scheduled? && not_rescheduled?
  end

  def reschedule
    self.scheduled = false
    self.delivered = false
    save(validate: false)
  end

end
