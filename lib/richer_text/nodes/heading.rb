module RicherText
  module Nodes
    class Heading < ::RicherText::Node
      def level
        attrs["level"]
      end
    end
  end
end
