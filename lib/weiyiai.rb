require 'net/http'
require_relative 'weiyiai/error/error'
require_relative 'weiyiai/openai/client'
require_relative 'weiyiai/slack/client'
require_relative 'weiyiai/client'

# USAGE
# require "weiyiai"
#
# Slack.configure do |config|
#   config.token = 'xapp-1-A0577R9J0HM-5257456449125-4c40d943af6192be723058c0baeab2c4e143aa065f0231557ca4b53ee4ebf13b'
# end
# @weiyiai = WeiyiAI::Client.new(
#   openai_configs: {
#     access_token: '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',
#     organization_id: 'org-Zrqf615iiugEtT3GNWBSkD3E'
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