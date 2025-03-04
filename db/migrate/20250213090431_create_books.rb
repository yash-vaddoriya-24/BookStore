class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.references :category, index: true, foreign_key: true, null: false
      t.string :isbn
      t.integer :price
      t.string :image_url
      t.integer :stock
      t.string :description

      t.timestamps
    end
  end
end
