require "action_view/helpers/tags/placeholderable"

module ActionView::Helpers
  class Tags::Editor < Tags::Base
    include Tags::Placeholderable

    delegate :dom_id, to: ActionView::RecordIdentifier

    def render
      options = @options.stringify_keys
      add_default_name_and_id(options)
      options["input"] ||= dom_id(object, [options["id"], :richer_text_input].compact.join("_")) if object
      options["value"] = options.fetch("value") { value&.to_html }

      @template_object.richer_text_area_tag(options.delete("name"), options["value"], options.except("value"))
    end
  end

  module FormHelper
    def richer_text_area(object_name, method, options = {})
      Tags::Editor.new(object_name, method, self, options).render
    end
  end

  class FormBuilder
    def richer_text_area(method, options = {})
      @template.richer_text_area(@object_name, method, objectify_options(options))
    end
  end
end

module RicherText
  module TagHelper
    cattr_accessor(:id, instance_accessor: false) { 0 }

    def richer_text_area_tag(name, value = nil, options = {})
      options = options.symbolize_keys
      options[:input] ||= "richer_text_input_#{RicherText::TagHelper.id += 1}"

      # So that we can access the content in the tiptap editor
      options[:content] ||= value

      input_tag = hidden_field_tag(name, value, id: options[:input])
      editor_tag = tag("richer-text-editor", options)

      input_tag + editor_tag
    end
  end
end
