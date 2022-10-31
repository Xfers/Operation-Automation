class SendMessageToSlackJob < ApplicationJob
  queue_as :default

  def perform(message)
    client = Slack::Web::Client.new
    client.chat_postMessage(channel: '#project-acw', text: message.description, as_user: true)
  end
end
