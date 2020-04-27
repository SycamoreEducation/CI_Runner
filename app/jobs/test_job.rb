class TestJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.debug "RUNNING A FREAKING TEST"
  end
end
