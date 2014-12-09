class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :entry_text

      t.timestamps
    end
  end
end
