class SendMessageToSlackJob < ApplicationJob
  queue_as :default

  def perform(message)
    client = Slack::Web::Client.new
    input = message.description.remove("\"")
    result = ReverseMarkdown.convert input
    #binding.pry
    client.chat_postMessage(channel: '#project-acw', text: result.inspect.remove("\""), as_user: true, mrkdwn: false)
  end
end
