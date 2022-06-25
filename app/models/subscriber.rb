class Subscriber < ApplicationRecord
  enum source: ['Search Engine', 'Social Media', 'Other']

  validates :email, presence: true, uniqueness: true

  after_create_commit :confirm

  scope :confirmed, lambda {
    where.not(confirmed_at: nil)
  }

  scope :unconfirmed, lambda {
    where(confirmed_at: nil)
  }

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.base58(24)
  end

  def send_confirmation_email
    self.confirmation_sent_at = Time.now
    ApplicationMailer.deliver(
      SubscriberMailer.send_confirmation_about_subscription(id)
    )
    save
  end

  def confirm
    return if confirmed?

    generate_confirmation_token
    send_confirmation_email
  end

  def skip_confirmation!
    self.confirmed_at = Time.now.utc
  end

  def confirm_subscription
    self.confirmed_at = Time.now
    save
  end

  def confirmation_email_sent?
    confirmation_sent_at.present?
  end

  def confirmed?
    confirmed_at.present?
  end
end
