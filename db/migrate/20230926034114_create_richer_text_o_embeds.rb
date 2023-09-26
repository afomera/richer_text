class CreateRicherTextOEmbeds < ActiveRecord::Migration[7.0]
  def change
    create_table :richer_text_o_embeds do |t|
      t.jsonb :fields
      t.string :url

      t.timestamps
    end
  end
end
