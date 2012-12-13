module Mailchecker
  module Generators
    class AssetsGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Create the javascript file to make the validation in client side."

      def copy_javascript
        copy_file "assets/mailchecker.js.coffee.erb", "app/assets/javascripts/mailchecker_client.js.coffee.erb"
        
        if File.exist?('app/assets/javascripts/application.js')
          insert_into_file "app/assets/javascripts/application.js", "//= require mailchecker_client\n", after: "jquery_ujs\n"
        else
          if File.exist?('app/assets/javascripts/application.js.coffee')
            insert_into_file "app/assets/javascripts/application.js.coffee", "#= require mailchecker_client\n", after: "jquery_ujs\n"
          end
        end
      end
    end
  end
end
