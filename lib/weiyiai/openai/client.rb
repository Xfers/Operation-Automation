# curl https://api.openai.com/v1/models \
#   -H "Authorization: Bearer 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"
module WeiyiAI
  module OpenAI
    class Client
      attr_writer :access_token, :organization_id
      attr_reader :response

      DEFAULT_API_VERSION = 'v1'.freeze
      DEFAULT_URI_BASE = 'https://api.openai.com/'.freeze
      DEFAULT_TIMEOUT = 120

      def initialize(access_token: nil, organization_id: nil)
        @access_token = access_token
        @organization_id = organization_id
      end

      # chat_res = @weiyiai.openai.chat(parameters: {messages: [{role: "user", content: "Summarize this page: https://zh.wikipedia.org/zh-tw/ChatGPT"}]})
      def chat(parameters: {})
        default_parameters = { model: 'gpt-3.5-turbo' }

        res = Net::HTTP.post(
          URI("#{base_uri}/chat/completions"), 
          JSON.generate(parameters.merge(default_parameters)),
          headers
        )

        respond(method: "#{__method__}", response: res)
      end

      # chat_res = @weiyiai.openai.completions(parameters: {prompt: "Say this is a test"})
      def completions(parameters: {})
        default_parameters = { model: 'text-davinci-003' }
        res = Net::HTTP.post(
          URI("#{base_uri}/completions"), 
          JSON.generate(parameters.merge(default_parameters)),
          headers
        )
        respond(method: "#{__method__}", response: res)
      end

      private def base_uri
        DEFAULT_URI_BASE + DEFAULT_API_VERSION
      end

      private def headers
        {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@access_token}",
          'OpenAI-Organization' => @organization_id
        }
      end

      private def respond(method: nil, response: nil)
        case response
        when Net::HTTPSuccess, Net::HTTPRedirection
          serialize(method: method, response_body: JSON.parse(response.body))
        else
          raise WeiyiAI::Error::OpenAIError, "[#{response.code}] #{response.body}"
        end
      end

      private def serialize(method: nil, response_body: nil)
        @response = response_body
        case method
        when "chat"
          @response['choices'].map { |h| h['message']['content'] }.join("\n")
        when "completions"
          @response['choices'].map { |h| h['text'] }.join("\n")
        end
      end
    end
  end
end
