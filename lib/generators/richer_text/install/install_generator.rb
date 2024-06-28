require "pathname"

module RicherText
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root RicherText::Engine.root

      def create_migrations
        rails_command "railties:install:migrations FROM=active_storage,richer_text", inline: true
      end

      def copy_files
        copy_file(
          "app/views/richer_text/contents/_content.html.erb",
          "app/views/richer_text/contents/_content.html.erb"
        )

        copy_file(
          "app/assets/stylesheets/richer_text/richer-text.css",
          "app/assets/stylesheets/richer-text.css"
        )
      end

      def install_javascript_dependencies
        destination = Pathname(destination_root)

        if destination.join("package.json").exist?
          say "Adding dependencies to package.json", :green

          run "npm install highlight.js @afomera/richer-text" if destination.join("package-lock.json").exist?
          run "bun add highlight.js @afomera/richer-text" if destination.join("bun.lockb").exist?
          run "yarn add highlight.js @afomera/richer-text" if destination.join("yarn.lock").exist?
          run "pnpm add highlight.js @afomera/richer-text" if destination.join("pnpm-lock.yaml").exist?
        end

        say "Adding import to application.js", :green
        append_to_file "app/javascript/application.js", %(import "@afomera/richer-text"\n)
      end

      def install_stylesheet_dependencies
        destination = Pathname(destination_root)

        if destination.join("app/assets/stylesheets/application.tailwind.css").exist?
          say "Adding import to application.tailwind.css", :green
          prepend_to_file "app/assets/stylesheets/application.tailwind.css", %(@import "@afomera/richer-text/dist/css/richer-text.css";\n@import "highlight.js/styles/github-dark.css";\n@import "richer-text.css";\n)
        elsif (stylesheets = Dir.glob "#{destination_root}/app/assets/stylesheets/application.*.{scss}").length > 0
          say "Adding import to #{stylesheets.first}", :green
          prepend_to_file stylesheets.first, %(@import "@afomera/richer-text/dist/css/richer-text";\n@import "highlight.js/styles/github-dark";\n@import "richer-text";\n)
        end
      end
    end
  end
end
