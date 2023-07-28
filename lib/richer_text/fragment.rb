module RicherText
  class Fragment
    class << self
      def parse(html)
        new(Nokogiri::HTML.fragment(html))
      end
    end

    attr_reader :source

    def initialize(source)
      @source = source
    end

    def find_all(selector)
      source.css(selector)
    end
  end
end
