# /lib/rails_ext/generated_attribute.rb

# Here, we patch the GeneratedAttribute class to add `richer_text` as a field type, which behaves much the same as the `rich_text` type.
# We will patch the Model generator as well to tweak the ActiveRecord model generated when this type is used
require 'rails/generators/generated_attribute'

module Rails
  module Generators
    class GeneratedAttribute
      DEFAULT_TYPES = %w(
        attachment
        attachments
        belongs_to
        boolean
        date
        datetime
        decimal
        digest
        float
        integer
        references
        rich_text
        string
        text
        time
        timestamp
        token
        richer_text
      )

      def field_type
        @field_type ||= case type
                        when :integer                  then :number_field
                        when :float, :decimal          then :text_field
                        when :time                     then :time_field
                        when :datetime, :timestamp     then :datetime_field
                        when :date                     then :date_field
                        when :text                     then :text_area
                        when :rich_text                then :rich_text_area
                        when :boolean                  then :check_box
                        when :attachment, :attachments then :file_field
                        when :richer_text              then :richer_text_area
                        else
                          :text_field
        end
      end

      def default
        @default ||= case type
                     when :integer                     then 1
                     when :float                       then 1.5
                     when :decimal                     then "9.99"
                     when :datetime, :timestamp, :time then Time.now.to_fs(:db)
                     when :date                        then Date.today.to_fs(:db)
                     when :string                      then name == "type" ? "" : "MyString"
                     when :text                        then "MyText"
                     when :boolean                     then false
                     when :references, :belongs_to,
                          :attachment, :attachments,
                          :rich_text, :richer_text     then nil
                     else
                       ""
        end
      end

      def virtual?
        richer_text? || rich_text? || attachment? || attachments?
      end

      def richer_text?
        type == :richer_text
      end
    end
  end
end
