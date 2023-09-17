module RicherText
  module Nodes
    class Callout < ::RicherText::Node
      def color
        attrs["data-color"]
      end
    end
  end
end
