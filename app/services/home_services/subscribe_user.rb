# frozen_string_literal: true

require 'email_validator'

module HomeServices
  class SubscribeUser < BaseService
    def initialize(subscriber_params)
      @subscriber_params = subscriber_params
    end

    def execute
      @subscriber = Subscriber.new(@subscriber_params)

      if @subscriber.valid?
        email_validator = EmailValidator.validate_email(@subscriber.email)

        return unsuccess_response(resource: @subscriber, message: email_validator) unless email_validator.success?

        deliverability = JSON.parse(email_validator.response.body)['deliverability']

        if deliverability == 'UNDELIVERABLE'
          return unsuccess_response(resource: @subscriber, message: 'Email is not valid.')
        end

      end

      if @subscriber.save
        success_response(resource: @subscriber, message: 'You will receive an email to confirm subscription.')
      else
        unsuccess_response(resource: @subscriber)
      end
    end
  end
end
