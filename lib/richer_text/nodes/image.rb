module RicherText
  module Nodes
    class Image < ::RicherText::Node
      def src
        @src ||= attrs['src']
      end

      def signed_id
        @signed_id = attrs['signedId']
      end

      def width
        attrs['width']
      end
    end
  end
end
