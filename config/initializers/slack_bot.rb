require 'slack-ruby-client'

Slack.configure do |config|
    config.token = ENV["SLACK_TOKEN"]

end