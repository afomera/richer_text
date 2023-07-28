require "active_support"
require "active_support/rails"

require "richer_text/version"
require "richer_text/engine"

module RicherText
  extend ActiveSupport::Autoload

  autoload :Attribute
  autoload :Content
  autoload :Fragment
  autoload :Serialization
end
