module RicherText
  module Nodes
    class AttachmentFigure < ::RicherText::Node
      def previewable?
        @attrs["previewable"]
      end

      def url
        @attrs["url"].presence || @attrs["src"]
      end

      def sgid
        @attrs["sgid"]
      end
    end
  end
end
