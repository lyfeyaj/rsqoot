module Rsqoot
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc <<-DESC
Description:
    Copies RSqoot configuration file to your application's initializer directory.
DESC

      def copy_config_file
        copy_file 'rsqoot_config.rb', 'config/initializers/rsqoot_config.rb'
      end
    end
  end
end
