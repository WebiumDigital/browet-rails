module Browet
  class InstallGenerator < Rails::Generators::Base
    desc "Installs Browet plugin"

    source_root File.expand_path('../../../browet', __FILE__)

    def create_initializer
      copy_file 'initializer.rb', 'config/initializers/browet.rb'
    end
  end
end
