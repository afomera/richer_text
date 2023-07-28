class CreateRicherTextRichTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :richer_text_rich_texts do |t|
      t.string :name, null: false
      t.text :body, size: :long
      t.references :record, null: false, polymorphic: true

      t.timestamps

      t.index [:record_type, :record_id, :name], name: "index_richer_texts_rich_texts_uniqueness", unique: true
    end
  end
end
