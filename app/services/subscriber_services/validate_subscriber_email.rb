module SubscriberServices
  class ValidateSubscriberEmail < BaseService
    def initialize(subscriber)
      @subscriber = subscriber
    end

    def execute
      if @subscriber.valid?
        email_validator = EmailValidator.validate_email(@subscriber.email)
        return unsuccess_response(resource: @subscriber, message: email_validator) unless email_validator.success?

        deliverability = JSON.parse(email_validator.response.body)['deliverability']

        if deliverability == 'UNDELIVERABLE'
          @subscriber.errors.add(:email, I18n.t('subscribers.invalid_email_error_message'))
          return unsuccess_response(resource: @subscriber, message: I18n.t('subscribers.invalid_email_error_message'))
        end
      end

      success_response(resource: @subscriber)
    end
  end
end
