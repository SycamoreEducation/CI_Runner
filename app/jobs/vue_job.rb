class VueJob < ApplicationJob
  queue_as :default

  def initialize(repo, sha, branch)
    @repo = repo
    @sha = sha
    @branch = branch
  end

  def perform
    client.create_status(repo, sha, 'processing', { context: 'Running Checks' })
  end

  private
    def client
      @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    end
end
