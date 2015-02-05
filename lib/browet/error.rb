module Browet

  class ConfigError < StandardError
    def initialize(message = 'Invalid congig parameter')
      super
    end
  end

  class HttpError < StandardError
    def initialize(error_code)
      super "HTTP error #{error_code}"
    end
  end

end
