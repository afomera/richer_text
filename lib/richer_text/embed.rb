module RicherText
  class Embed
    include Rendering

    def self.find(sgid)
      @embed = GlobalID::Locator.locate_signed(sgid, for: "embeddable")
      new(@embed) if @embed
    end

    attr_reader :embed

    def initialize(embed)
      @embed = embed
    end

    def object
      @embed
    end

    delegate :to_embeddable_partial_path, to: :@embed
    delegate :model_name, to: :@embed

    def html
      render partial: to_embeddable_partial_path, object: object, as: model_name.element
    end
  end
end
