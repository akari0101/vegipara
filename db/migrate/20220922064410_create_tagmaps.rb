class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.references :item, null: false, foreign_key: true, type: :integer
      t.references :tag, null: false, foreign_key: true, type: :integer

      t.timestamps
    end
  end
end
