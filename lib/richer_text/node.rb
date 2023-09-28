module RicherText
  class Node
    attr_reader :json, :attrs, :children, :type
    include RicherText::Rendering

    STYLES = {
      "textAlign" => "text-align"
    }

    def self.build(json)
      node = json.is_a?(String) ? JSON.parse(json) : json
      klass = "RicherText::Nodes::#{node["type"].underscore.classify}".constantize
      klass.new(node) if klass
    end

    def initialize(json)
      @json = json
      @attrs = json.fetch("attrs", {})
      @type = json.fetch("type", "text")
      @children = json.fetch("content", []).map { |child| self.class.build(child) }
    end

    def style
      @attrs.select { |k, v| STYLES.key?(k) }.map { |k, v| "#{STYLES[k]}: #{v};" }.join
    end

    def accept(visitor)
      visitor.send("visit_#{type.underscore}", self)
    end
  end
end
