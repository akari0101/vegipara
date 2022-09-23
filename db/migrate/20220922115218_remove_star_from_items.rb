class RemoveStarFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :star, :string
  end
end
