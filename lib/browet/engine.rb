require 'rails'

module Browet
  class Engine < ::Rails::Engine
    isolate_namespace Browet
    require 'selectize-rails'
  end
end
