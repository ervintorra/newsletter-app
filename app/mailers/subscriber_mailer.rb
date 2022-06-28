class SubscriberMailer < ApplicationMailer

  def send_confirmation_about_subscription(subscriber_id)
    @subscriber = Subscriber.find(subscriber_id)
    @subject = 'Confirm your subscription.'

    Rails.logger.info "Begin Sending Send Confirmation About Subscription for user: #{@subscriber.name}(#{@subscriber.email})."
    mail(to: @subscriber.email, subject: @subject)
    Rails.logger.info "Finished Sending Send Confirmation About Subscription for user: #{@subscriber.name}(#{@subscriber.email})."
  end

end
