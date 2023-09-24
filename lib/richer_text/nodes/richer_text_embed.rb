module RicherText
  module Nodes
    class RicherTextEmbed < ::RicherText::Node
      def sgid
        attrs["sgid"]
      end

      def html
        render partial: embeddable.to_attachable_partial_path, object: embeddable, as: embeddable.model_name.element
      rescue ActiveRecord::RecordNotFound
        "" # TODO: handle this better
      end

      def embeddable
        @embeddable ||= GlobalID::Locator.locate_signed(sgid, for: "attachable")
      end
    end
  end
end
