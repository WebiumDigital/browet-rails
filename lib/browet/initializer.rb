# Browet Global Configuration
Browet.init do |config|

  # Browet API URL
  config.version = 'v1'

  # Browet API account
  config.account = ''

  # Browet API tokens
  config.default_token = ''
  config.localized_tokens = {
    # :ru => 'token for ru locale',
    # :en => 'token for en locale'
  }

  # Cache life time (hours)
  config.ttl = 8

  # Disable cache
  config.enable_cache = true

end
