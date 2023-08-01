require "active_support"
require "active_support/rails"

require "richer_text/generated_attributes"
require "richer_text/version"
require "richer_text/engine"

module RicherText
  extend ActiveSupport::Autoload

  autoload :Attribute
  autoload :Content
  autoload :Rendering
  autoload :Fragment
  autoload :Serialization
end
