require 'rails/generators'
require "rails/generators/active_record"

module Browet
  class InstallGenerator < ActiveRecord::Generators::Base
    desc "Installs Browet plugin"

    source_root File.expand_path('../../../browet', __FILE__)

    def create_initializer
      copy_file 'initializer.rb', 'config/initializers/browet.rb'
    end

    def create_migration
      migration_template 'migration.rb', 'db/migrate/create_browet_cache.rb'
    end
  end
end
