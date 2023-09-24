module RicherText
  module Embeddable
    extend ActiveSupport::Concern

    included do
      def embeddable_sgid
        to_sgid(expires_in: nil, for: "embeddable").to_s
      end

      def to_embeddable_partial_path
        to_partial_path
      end
    end
  end
end
