require "action_view/helpers/tags/placeholderable"

module ActionView::Helpers
  class Tags::Editor < Tags::Base
    include Tags::Placeholderable

    def render
      options = @options.stringify_keys
      options["value"] = options.fetch("value") { value&.to_html }
      add_default_name_and_id(options)

      @template_object.richer_text_area_tag(options["name"], options["value"], options.except("value"))
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
      options[:id] ||= "editor_input_#{TagHelper.id += 1}"
      options[:class] ||= "editor-input"

      # So that we can access the content in the tiptap editor
      options[:content] ||= value

      # editor_toolbar(id: options[:id]) + content_tag("textarea", value, options)
      content_tag("div", data: { controller: "richer-text-editor", action: "editor:update->richer-text-editor#update" }) do
        hidden_field_tag(name, value, { class: "w-full", data: { richer_text_editor_target: "input" } }) +
        tag("richer-text-editor", options)
      end
    end
  end
end
