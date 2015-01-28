class BrowetGenerator < Rails::Generators::Base
  desc "This generator creates an Browet initializer file"

  source_root File.expand_path('../../browet', __FILE__)

  def create_initializer
    copy_file 'initializer.rb', 'config/initializers/browet.rb'
  end

end
