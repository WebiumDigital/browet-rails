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

  # service url for widgets (widget related url isolation)
  config.widgets_root_url = 'browet'

  # product search widget
  config.product_search_autocomplete_url = 'product_search_autocomplete'  # autocomplete url
  config.product_search_autocomplete_length = 3     # min string length to triger autocomplete

end
