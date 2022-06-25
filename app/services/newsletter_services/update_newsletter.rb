module NewsletterServices
  class UpdateNewsletter < BaseService
    def initialize(newsletter, newsletter_params)
      @newsletter = newsletter
      @newsletter_params = newsletter_params
    end

    def execute
      @newsletter.assign_attributes(@newsletter_params)
      @newsletter.reschedule if @newsletter.valid? && @newsletter.publish_at_changed?

      if @newsletter.save
        success_response(resource: @newsletter, message: "Newsletter was successfully updated.")
      else
        unsuccess_response(resource: @newsletter)
      end
    end
  end
end
