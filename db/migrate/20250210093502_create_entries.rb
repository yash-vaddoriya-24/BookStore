class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.references :entryable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
