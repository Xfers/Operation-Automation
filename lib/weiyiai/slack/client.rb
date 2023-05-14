module WeiyiAI
  module Slack
    class Client
      attr_accessor :connection, :realtime_connection
      attr_reader :default_channel
      def initialize(connection: nil, realtime_connection: nil, default_channel: nil)
        @connection = connection
        @realtime_connection = realtime_connection
        @default_channel = default_channel
      end

      def post
        @connection.chat_postMessage(
          channel: @channel,
          as_user: true,
          mrkdwn: true,
          blocks: [
            {
              "type": 'section',
              "text": {
                "type": 'mrkdwn',
                "text": result.gsub('**', '*')
              }
            }
          ]
        )
      end

      def listen
        @realtime_connection.on :hello do
          puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
        end

        @realtime_connection.on :message do |data|
          case data.text
          when 'bot hi'
            @realtime_connection.message(channel: data.channel, text: "Hi <@#{data.user}>!")
          when /^bot/
            @realtime_connection.message(channel: data.channel, text: "Sorry <@#{data.user}>, what?")
          end
        end

        @realtime_connection.on :close do |_data|
          puts 'Client is about to disconnect'
        end

        @realtime_connection.on :closed do |_data|
          puts 'Client has disconnected successfully!'
        end

        @realtime_connection.start!
      end
    end
  end
end
