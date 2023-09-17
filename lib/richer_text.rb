require "active_support"
require "active_support/rails"

require "richer_text/version"
require "richer_text/engine"

module RicherText
  extend ActiveSupport::Autoload

  autoload :Attribute
  autoload :Content
  autoload :Rendering
  autoload :Fragment
  autoload :Serialization
  autoload :TagHelper

  autoload :Node
  autoload :Mark
  autoload :HTMLVisitor

  module Nodes
    extend ActiveSupport::Autoload

    autoload :Blockquote
    autoload :BulletList
    autoload :Callout
    autoload :CodeBlock
    autoload :Doc
    autoload :HardBreak
    autoload :Heading
    autoload :HorizontalRule
    autoload :Image
    autoload :ListItem
    autoload :Paragraph
    autoload :OrderedList
    autoload :Text
    autoload :Table
    autoload :TableCell
    autoload :TableRow
    autoload :TableHeader
  end

  class << self
    def default_renderer
      @default_renderer ||= RicherText::HTMLVisitor.new
    end

    attr_writer :default_renderer
  end
end
