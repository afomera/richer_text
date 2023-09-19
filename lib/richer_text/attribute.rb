module RicherText
  module Attribute
    extend ActiveSupport::Concern

    class_methods do
      def has_richer_text(name, store_as: :html)
        # Store if the attribute is using JSON or not.
        class_attribute :"richer_text_#{name}_json", instance_writer: false
        self.send(:"richer_text_#{name}_json=", store_as == :json)

        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{name}
            richer_text_#{name} || build_richer_text_#{name}
          end

          def #{name}?
            richer_text_#{name}.present?
          end

          def #{name}=(body)
            self.#{name}.body = body
          end
        CODE

        has_one :"richer_text_#{name}", -> { where(name: name) },
          class_name: store_as == :json ? "RicherText::JsonText" : "RicherText::RichText", as: :record, inverse_of: :record, autosave: true, dependent: :destroy

        scope :"with_richer_text_#{name}", -> { includes("richer_text_#{name}") }
      end

      # Eager load all dependent RichText models in bulk.
      def with_all_richer_text
        eager_load(richer_text_association_names)
      end

      def richer_text_association_names
        reflect_on_all_associations(:has_one).collect(&:name).select { |n| n.start_with?("richer_text_") }
      end
    end
  end
end
