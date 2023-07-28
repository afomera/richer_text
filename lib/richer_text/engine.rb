require "rails"
require "nokogiri"

module RicherText
  class Engine < ::Rails::Engine
    isolate_namespace RicherText

    initializer "richer_text.attribute" do
      ActiveSupport.on_load(:active_record) do
        include RicherText::Attribute
      end
    end
  end
end
