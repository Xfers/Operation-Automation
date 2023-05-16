module WeiyiAI
  module Error
    class ConfigurationError < StandardError; end
    class OpenAIError < StandardError; end
    class SlackError < StandardError; end
  end
end
