module RicherText
  class RichText < ApplicationRecord
    belongs_to :record, polymorphic: true

    serialize :body, RicherText::Content

    delegate :to_s, :nil?, to: :body

    has_many_attached :images

    before_save :update_images

    def to_html
      body&.to_html
    end

    private

    def update_images
      self.images = body.image_blobs if body.present?
    end
  end
end
