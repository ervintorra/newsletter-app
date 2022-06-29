class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.EMAIL_ADDRESS
  layout 'mailer'

  def self.deliver(email, wait_seconds = 0.seconds)
    if wait_seconds.positive?
      email.deliver_later(wait: wait_seconds)
    else
      email.deliver_now
    end

    email_sent_success_response
    # rescue EOFError => ex
  rescue StandardError => ex
    email_sent_failed_response(email, ex)
    # raise Net::SMTPUnknownError, ex
  end

  private_class_method def self.email_sent_success_response
    OpenStruct.new({ success?: true })
  end

  private_class_method def self.email_sent_failed_response(email, ex)
    message = I18n.t('flash_message.failed_sending_email_error_message', email: email.to.join(', '))
    Rails.logger.error ex.message

    OpenStruct.new({ success?: false, message: message })
  end
end
