class ProcessingController < ApplicationController
  def create
    Rails.logger.debug "RUNNING ACTION: #{action}"
    case action
    when 'pull_request'
      Rails.logger.debug 'run pull request'
      client.create_status(
        params[:pull_request][:head][:repo][:full_name],
        params[:pull_request][:head][:sha],
        'pending',
        { context: 'Eslint Checks' }
      )
    end
  end

  private
    def client
      @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    end

    def action
      request.headers['HTTP_X_GITHUB_EVENT']
    end
end
