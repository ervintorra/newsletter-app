class CheckForNewslettersToScheduleJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Checking for new newsletters to schedule...'

    JobServices::ScheduleNextNewslettersInRow.call
  end
end
