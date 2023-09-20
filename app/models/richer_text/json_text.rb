module RicherText
  class JsonText < ApplicationRecord
    DEFAULT_BODY = {"type" => "doc", "content" => [{"type" => "paragraph", "attrs" => {"textAlign" => "left"}}]}

    belongs_to :record, polymorphic: true, touch: true

    serialize :body, JSON, default: DEFAULT_BODY.to_json

    has_many_attached :images
    has_many_attached :rhino_attachments # For handling attachments in the Rhino Editor

    before_save :update_attachments

    def to_editor_format
      body
    end

    def to_s
      RicherText.default_renderer.visit(document)
    end

    private

    def update_attachments
      self.images = image_nodes.map(&:signed_id)
      self.rhino_attachments = rhino_attachment_records.map(&:signed_id)
    end

    def image_nodes
      find_nodes_of_type(RicherText::Nodes::Image).flatten.compact_blank
    end

    def rhino_attachment_nodes
      find_nodes_of_type(RicherText::Nodes::AttachmentFigure).flatten.compact_blank
    end

    def rhino_attachment_records
      sgids = rhino_attachment_nodes.map(&:sgid).compact_blank
      GlobalID::Locator.locate_many_signed(sgids, for: "attachable")
    end

    def find_nodes_of_type(type, node = document)
      if node.children.any?
        return node if node.is_a?(type)

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
