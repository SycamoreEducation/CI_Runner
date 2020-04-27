class TestWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.debug "TESTING WORKER"
  end

end
