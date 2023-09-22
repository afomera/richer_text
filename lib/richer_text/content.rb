module RicherText
  class Content
    include ActiveModel::Conversion, Serialization, Rendering

    delegate :blank?, :empty?, :html_safe, :present?, to: :to_html

    def initialize(body)
      @body = body

      @fragment = RicherText::Fragment.parse(body)
    end

    def inspect
      "#<#{self.class.name} #{to_html.truncate(25).inspect}>"
    end

    def to_s
      render partial: to_partial_path, layout: false, locals: { content: self }
    end

    def to_html
      body
    end

    def images
      @images ||= fragment.find_all("img").map do |img|
        img.attributes["src"].value
      end.uniq
    end

    def mentionees_global_ids
      global_ids = fragment.find_all("span[data-type=mention]").map do |span|
        span.attributes["data-id"].value
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

    attr_reader :fragment
    attr_accessor :body
  end
end
