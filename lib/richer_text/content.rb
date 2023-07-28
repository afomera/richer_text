module RicherText
  class Content
    include Serialization

    delegate :blank?, :empty?, :html_safe, :present?, to: :to_html

    def initialize(body)
      @body = body

      @fragment = RicherText::Fragment.parse(body)
    end

    def inspect
      "#<#{self.class.name} #{to_html.truncate(25).inspect}>"
    end

    def to_s
      to_html
    end

    def to_html
      body
    end

    def images
      @images ||= fragment.find_all("img").map do |img|
        img.attributes["src"].value
      end.uniq
    end

    def image_blobs
      image_blob_ids.map { |id| ActiveStorage::Blob.find_signed(id) }
    end

    def image_blob_ids
      images.map do |image|
        # Ensure old images from ActionText which used the proxy url are supported
        image = image.gsub("/proxy/", "/redirect/")
        # Fetch the signed_blob_id from the image src
        image.split("/rails/active_storage/blobs/redirect/").last.split("/").first
      end
    end

    attr_reader :body, :fragment
  end
end
