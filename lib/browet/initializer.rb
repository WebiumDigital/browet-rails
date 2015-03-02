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

  # Cache life time (minutes)
  config.ttl = 10

  # Disable cache
  config.enable_cache = true

  # Addressing type (:slug or :id)
  config.identity = :slug

  # autocomplite url for product search widget
  config.product_search_url = 'product_search_url'
  
end
