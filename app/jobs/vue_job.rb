class VueJob < ApplicationJob
  queue_as :high_priority

  def initialize(repo, sha, branch)
    @repo = repo
    @sha = sha
    @branch = branch
  end

  def perform
    resp = Shell.execute("cd ~/SycamoreSchoolVue; git checkout #{@branch} --no-verify; git pull; yarn lint --no-fix")
    Rails.logger.debug resp.success?
    Rails.logger.debug resp.stdout
    Rails.logger.debug resp.stderr
    client.create_status(@repo, @sha, resp.success? ? 'success' : 'failure', { context: 'Eslint Checks' })
  end

  private
    def client
      @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    end
end
