module SubscriberServices
  class CreateSubscriber < BaseService
    def initialize(subscriber_params)
      @subscriber_params = subscriber_params
    end

    def execute
      @subscriber = Subscriber.new(@subscriber_params)

      email_validator_resp = ValidateSubscriberEmail.call(@subscriber)
      unless email_validator_resp.success?
        return unsuccess_response(resource: email_validator_resp.resource, message: email_validator_resp.message)
      end

      if @subscriber.save
        success_response(resource: @subscriber, message: I18n.t('subscribers.created_success_message'))
      else
        unsuccess_response(resource: @subscriber)
      end
    end
  end
end
