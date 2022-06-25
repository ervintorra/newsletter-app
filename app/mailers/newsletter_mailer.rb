class NewsletterMailer < ApplicationMailer

  def send_newsletter(newsletter_id, subscriber_id)
    @newsletter = Newsletter.find(newsletter_id)
    @subscriber = Subscriber.find(subscriber_id)

    return if !@newsletter&.ready_to_publish? || !@subscriber&.confirmed?

    @subject = @newsletter.title

    Rails.logger.info "Begin Sending Send Newsletter for Subscriber: #{@subscriber.name}(#{@subscriber.email})."
    mail(to: @subscriber.email, subject: @subject)
    Rails.logger.info "Finished Sending Send Newsletter for Subscriber: #{@subscriber.name}(#{@subscriber.email})."
  end
end
