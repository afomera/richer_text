module RicherText
  module Nodes
    class Mention < ::RicherText::Node
      def initialize(json)
        @marks = json.fetch("marks", []).map { |mark| RicherText::Mark.new(mark) }
        super(json)
      end

      def accept(visitor)
        visitor.visit_mention(self, @marks)
      end

      def user
        @user ||= GlobalID::Locator.locate(@attrs["id"])
      end

      def id
        @attrs["id"]
      end

      def name
        @user.respond_to?(:name) ? @user.name : @attrs["label"]
      end

      def avatar_url
        @user.respond_to?(:avatar_url) ? @user.avatar_url : @attrs["avatarUrl"]
      end
    end
  end
end
