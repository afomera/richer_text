require "rails"
require "oembed"

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

    config.after_initialize do
      ::OEmbed::Providers.register_all
      ::OEmbed::Providers.register_fallback(
        ::OEmbed::ProviderDiscovery,
        ::OEmbed::Providers::Noembed
      )
    end
  end
end
