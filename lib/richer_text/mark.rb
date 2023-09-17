module RicherText
  class Mark
    attr_reader :attrs, :type

    TAGS = {
      "bold" => "strong",
      "italic" => "em",
      "strike" => "del",
      "code" => "code",
      "highlight" => "mark",
      "link" => "a"
    }

    def initialize(json)
      @attrs = json.fetch("attrs", {})
      @type = json.fetch("type", nil)
    end

    def tag
      TAGS[type] || "span"
    end
  end
end
