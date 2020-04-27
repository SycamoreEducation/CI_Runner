class ProcessingController < ApplicationController
  def create
    repo = params[:pull_request][:head][:repo][:full_name]
    sha = params[:pull_request][:head][:sha]
    branch = [:pull_request][:head][:ref]

    client.create_status(repo, sha, 'pending', { context: 'Eslint Checks'})
    VueJob.perform_now(rep, sha, branch)
  end

  private
    def client
      @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    end

    def action
      request.headers['HTTP_X_GITHUB_EVENT']
    end
end
