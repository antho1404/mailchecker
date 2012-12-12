module Mailchecker
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Mail-checker initializer and copy locale files to your application."

      def copy_initializer
        template "mailchecker.rb", "config/initializers/mailchecker.rb"
      end

      def copy_locales
        copy_file "../../../locales/en.yml", "config/locales/mailchecker.en.yml"
        copy_file "../../../locales/fr.yml", "config/locales/mailchecker.fr.yml"
      end
    end
  end
end
