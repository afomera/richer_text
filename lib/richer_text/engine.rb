require "rails"

module RicherText
  class Engine < ::Rails::Engine
    isolate_namespace RicherText

    initializer "richer_text.attribute" do
      ActiveSupport.on_load(:active_record) do
        include RicherText::Attribute
      end
    end

    initializer "richer_text.helper" do
      ActiveSupport.on_load(:action_controller) do
        helper RicherText::TagHelper
      end
    end
  end
end
