module SubscriberServices
  class UpdateSubscriber < BaseService
    def initialize(subscriber, update_params)
      @subscriber = subscriber
      @update_params = update_params
    end

    def execute
      @subscriber.assign_attributes(@update_params)

      if @subscriber.email_changed?
        email_validator_resp = SubscriberServices::ValidateSubscriberEmail.call(@subscriber)
        unless email_validator_resp.success?
          return unsuccess_response(resource: email_validator_resp.resource, message: email_validator_resp.message)
        end

        @subscriber.resend_send_confirmation_instructions if @subscriber.valid?
      end

      if @subscriber.save
        success_response(resource: @subscriber, message: I18n.t('subscribers.updated_success_message'))
      else
        unsuccess_response(resource: @subscriber)
      end
    end
  end
end
