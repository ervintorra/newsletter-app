module SubscriberServices
  class CreateSubscriber < BaseService
    def initialize(subscriber_params)
      @subscriber_params = subscriber_params
    end

    def execute
      @subscriber = Subscriber.new(@subscriber_params)
      if @subscriber.save

        @subscriber.send_confirmation_email

        success_response(resource: @subscriber, message: 'Subscriber was successfully created.')
      else
        unsuccess_response(resource: @subscriber)
      end
    end

  end
end
