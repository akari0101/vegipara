class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.boolean :is_active, null: false, default: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.references :customer, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
