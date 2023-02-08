class SendMessageToSlackJob < ApplicationJob
  queue_as :default

  def perform(message)
    client = Slack::Web::Client.new
    input = message.description.remove("\"")
    result = ReverseMarkdown.convert input.gsub(/<pre.*>/, "`").gsub("</pre>", "`")
    client.chat_postMessage(channel: '#project-acw', 
      as_user: true, 
      mrkdwn: true,
      blocks: [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": result.gsub("**","*")
          }
        }
      ])
  end
end
