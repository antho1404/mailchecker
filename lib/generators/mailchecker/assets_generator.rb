module Mailchecker
  module Generators
    class AssetsGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Create the javascript file to make the validation in client side."

      def copy_javascript
        template "assets/mailchecker.js.coffee.erb", "app/assets/javascripts/mailchecker_client.js.coffee.erb"
      end
    end
  end
end
