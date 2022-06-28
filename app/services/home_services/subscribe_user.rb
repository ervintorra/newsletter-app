# frozen_string_literal: true

require 'email_validator'

module HomeServices
  class SubscribeUser < BaseService
    def initialize(subscriber_params)
      @subscriber_params = subscriber_params
    end

    def execute
      @subscriber = Subscriber.new(@subscriber_params)

      email_validator_resp = SubscriberServices::ValidateSubscriberEmail.call(@subscriber)
      unless email_validator_resp.success?
        return unsuccess_response(resource: email_validator_resp.resource, message: email_validator_resp.message)
      end

      if @subscriber.save
        success_response(resource: @subscriber, message: 'You will receive an email to confirm subscription.')
      else
        unsuccess_response(resource: @subscriber)
      end
    end
  end
end
