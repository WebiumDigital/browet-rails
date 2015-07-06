require "browet/version"
require "her"
require "her/kaminari"
require "faraday_middleware"

module Browet
  class Options < OpenStruct; end
  mattr_accessor :options

  self.options = Options.new(
    browet_domain:    'browet.com',
    client_domain:    '',
    client_token:     '',
    api_version:      '2',
    cache:            nil
  )

  autoload :Base,                  'browet/base'
  autoload :Api,                   'browet/api'
  autoload :Authentication,        'browet/authentication'
  autoload :Category,              'browet/category'
  autoload :CategoryGroup,         'browet/category_group'
  autoload :Brand,                 'browet/brand'
  autoload :Product,               'browet/product'
  autoload :ProductProperty,       'browet/product_property'
  autoload :Picture,               'browet/picture'
end