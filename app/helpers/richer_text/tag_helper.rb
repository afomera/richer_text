require "action_view/helpers/tags/placeholderable"

module ActionView::Helpers
  class Tags::Editor < Tags::Base
    include Tags::Placeholderable

    delegate :dom_id, to: ActionView::RecordIdentifier

    def render
      options = @options.stringify_keys
      add_default_name_and_id(options)
      options["input"] ||= dom_id(object, [options["id"], :richer_text_input].compact.join("_")) if object
      options["value"] = options.fetch("value") { value&.to_editor_format }
      options["serializer"] = options.fetch("serializer") { object.class.send(:"richer_text_#{@method_name}_json") ? "json" : "html" }

      @template_object.richer_text_area_tag(options.delete("name"), options["value"], options.except("value"))
    end
  end

  class Tags::RhinoEditor < Tags::Base
    include Tags::Placeholderable

    delegate :dom_id, to: ActionView::RecordIdentifier

    def render
      options = @options.stringify_keys
      add_default_name_and_id(options)
      options["input"] ||= dom_id(object, [options["id"], :rhino_text_input].compact.join("_")) if object
      options["value"] = options.fetch("value") { value&.to_editor_format }
      options["serializer"] = options.fetch("serializer") { "html"}

      @template_object.rhino_text_area_tag(options.delete("name"), options["value"], options.except("value"))
    end
  end

  module FormHelper
    def richer_text_area(object_name, method, options = {})
      Tags::Editor.new(object_name, method, self, options).render
    end

    def rhino_text_area(object_name, method, options = {})
      Tags::RhinoEditor.new(object_name, method, self, options).render
    end
  end

  class FormBuilder
    def richer_text_area(method, options = {})
      @template.richer_text_area(@object_name, method, objectify_options(options))
    end

    def rhino_text_area(method, options = {})
      @template.rhino_text_area(@object_name, method, objectify_options(options))
    end
  end
end

module RicherText
  module TagHelper
    cattr_accessor(:id, instance_accessor: false) { 0 }

    def richer_text_area_tag(name, value = nil, options = {})
      options = RicherText.default_form_options.merge(options.symbolize_keys).symbolize_keys
      options[:input] ||= "richer_text_input_#{RicherText::TagHelper.id += 1}"

      # So that we can access the content in the tiptap editor
      options[:content] ||= value

      # So we can choose the serializer to use, e.g. "html" or "json"
      options[:serializer] ||= "html"

      input_tag = hidden_field_tag(name, value, id: options[:input])
      editor_tag = tag("richer-text-editor", options)

      input_tag + editor_tag
    end

    def rhino_text_area_tag(name, value = nil, options = {})
      options = options.symbolize_keys
      options[:input] ||= "rhino_text_input_#{RicherText::TagHelper.id += 1}"

      # So we can choose the serializer to use, e.g. "html" or "json"
      options[:serializer] ||= "html"

      input_tag = hidden_field_tag(name, value, id: options[:input])
      editor_tag = tag("rhino-editor", { input: options[:input], serializer: "json",  data: { "blob-url-template": rails_service_blob_url(":signed_id", ":filename"), "direct-upload-url": rails_direct_uploads_url }}.merge(options))

      input_tag + editor_tag
    end
  end
end
