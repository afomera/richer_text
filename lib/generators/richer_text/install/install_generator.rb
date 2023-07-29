require "pathname"

module RicherText
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root RicherText::Engine.root

      def create_migrations
        rails_command "railties:install:migrations FROM=active_storage,richer_text", inline: true
      end

      def install_javascript_dependencies
        destination = Pathname(destination_root)

        if destination.join("package.json").exist?
          say "Adding dependencies to package.json", :green
          run "yarn add react react-dom highlight.js @afomera/richer-text"
        end

        say "Adding import to application.js", :green
        append_to_file "app/javascript/application.js", %(import "@afomera/richer-text"\n)
      end

      def install_stylesheet_dependencies
        destination = Pathname(destination_root)

        if destination.join("app/assets/stylesheets/application.tailwind.css").exist?
          say "Adding import to application.tailwind.css", :green
          prepend_to_file "app/assets/stylesheets/application.tailwind.css", %(@import "@afomera/richer-text/dist/css/richer-text.css";\n@import "highlight.js/styles/github-dark.css";\n)
        end
      end

      def generate_stimulus_controller
        say "Copying Stimulus controller", :green
        copy_file "app/javascript/controllers/richer_text_editor_controller.js", "app/javascript/controllers/richer_text_editor_controller.js"

        say "Updating Stimulus manifest", :green
        rails_command "stimulus:manifest:update"
      end
    end
  end
end
