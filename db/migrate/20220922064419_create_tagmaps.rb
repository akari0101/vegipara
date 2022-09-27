class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      # t.references :item, null: false, foreign_key: true


      t.references :item, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      # t.references :item, null: false, foreign_key: true, type: :integer
      # t.references :tag, null: false, foreign_key: true, type: :integer

      t.timestamps
    end

    # add_foreign_key "tagmaps", "items"
    # add_foreign_key "tagmaps", "tags"
  end
end
