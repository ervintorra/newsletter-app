module SubscriberServices
  class ConfirmSubscription < BaseService
    def initialize(token)
      @token = token
    end

    def execute
      return unsuccess_response(message: 'Invalid link.') unless @token.present?

      @subscriber = Subscriber.find_by(confirmation_token: @token)

      return unsuccess_response(message: 'Subscriber does not exists.') unless @subscriber

      return unsuccess_response(message: 'You are already subscribed.') if @subscriber.confirmed?

      @subscriber.confirm_subscription
      success_response(resource: @subscriber, message: 'You subscribed successfully to our newsletter.')
    end
  end
end
