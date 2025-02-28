class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.references :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
