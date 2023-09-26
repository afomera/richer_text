module RicherText
  module Nodes
    class RicherTextEmbed < ::RicherText::Node
      def sgid
        attrs["sgid"]
      end

      def html
        render partial: embeddable.to_embeddable_partial_path, object: embeddable, as: embeddable.model_name.element
      rescue ActiveRecord::RecordNotFound, NoMethodError
        "" # TODO: handle this better
      end

      def embeddable
        @embeddable ||= GlobalID::Locator.locate_signed(sgid, for: "embeddable")
      end
    end
  end
end
