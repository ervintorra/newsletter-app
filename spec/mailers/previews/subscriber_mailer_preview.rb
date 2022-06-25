class SubscriberMailerPreview < ActionMailer::Preview
  def send_confirmation_about_subscription
    @subscriber = Subscriber.last

    SubscriberMailer.send_confirmation_about_subscription(@subscriber.id)
  end
end
