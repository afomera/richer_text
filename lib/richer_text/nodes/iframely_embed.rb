module RicherText
  module Nodes
    class IframelyEmbed < ::RicherText::Node
      def href
        @attrs["href"]
      end

      def html
        "<div class='iframely'>
          #{@attrs["previewHtml"]}
        </div>"
      end
    end
  end
end
