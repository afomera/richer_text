module RicherText
  class JsonText < ApplicationRecord
    DEFAULT_BODY = {"type" => "doc", "content" => [{"type" => "paragraph", "attrs" => {"textAlign" => "left"}}]}

    belongs_to :record, polymorphic: true, touch: true

    serialize :body, JSON, default: DEFAULT_BODY.to_json

    has_many_attached :images

    before_save :update_images

    def to_editor_format
      body
    end

    def to_s
      RicherText.default_renderer.visit(document)
    end

    private

    def update_images
      self.images = image_nodes.map(&:signed_id)
    end

    def image_nodes
      find_nodes_of_type(RicherText::Nodes::Image).flatten.compact_blank
    end

    def find_nodes_of_type(type, node = document)
      if node.children.any?
        node.children.map { |child| find_nodes_of_type(type, child) }
      else
        node.is_a?(type) ? node : nil
      end
    end

    def document
      @document ||= RicherText::Node.build(body)
    end
  end
end
