module RicherText
  module Nodes
    class Text < ::RicherText::Node
      def initialize(json)
        @marks = json.fetch("marks", []).map { |mark| RicherText::Mark.new(mark) }
        super(json)
      end

      def text
        json["text"]
      end

      def accept(visitor)
        visitor.visit_text(self, @marks)
      end
    end
  end
end
