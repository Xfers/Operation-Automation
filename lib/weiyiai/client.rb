
module WeiyiAI
  class Client
    attr_accessor :openai, :slack
    def initialize(openai_configs: nil, slack_configs: nil, default_channel: nil)
      @openai = WeiyiAI::OpenAI::Client.new(openai_configs)
      @slack = WeiyiAI::Slack::Client.new(slack_configs)
    end

    def prompt
      # @openai.chat
    end
    
    def respond
      # @slack.post
    end
  end
end
