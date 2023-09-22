module RicherText
  class RichText < ApplicationRecord
    belongs_to :record, polymorphic: true, touch: true

    serialize :body, RicherText::Content

    delegate :to_s, :nil?, to: :body
    delegate :blank?, :empty?, :present?, to: :to_html

    has_many_attached :images

    before_save :update_images

    def to_html
      body&.to_html&.to_s
    end

    def to_editor_format
      body&.to_html&.to_s
    end

    def mentionees
      global_ids = body&.mentionees_global_ids

      GlobalID::Locator.locate_many(global_ids)
    end

    private

    def update_images
      self.images = body.image_blobs if body.present?
    end
  end
end
