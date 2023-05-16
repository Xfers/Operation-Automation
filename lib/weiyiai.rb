require 'net/http'
require_relative 'weiyiai/error/error'
require_relative 'weiyiai/openai/client'
require_relative 'weiyiai/slack/client'
require_relative 'weiyiai/client'

# USAGE
# require "weiyiai"
#
# Slack.configure do |config|
#   config.token = 'TOKEN'
# end
# @weiyiai = WeiyiAI::Client.new(
#   openai_configs: {
#     access_token: 'TOKEN',
#     organization_id: 'ORG_ID'
#   },
#   slack_configs: {
#     connection: Slack::Web::Client.new,
#     realtime_connection: Slack::RealTime::Client.new,
#     default_channel: '#project-acw'
#   }
# )
# chat_res = @weiyiai.openai.chat(
#   parameters: {
#     messages: [{ role: 'user', content: 'Summarize this page: https://zh.wikipedia.org/zh-tw/ChatGPT' }]
#   }
# )
# chat_res = @weiyiai.openai.completions(parameters: {prompt: "What is top 10 news today"})
# @weiyiai.slack.listen