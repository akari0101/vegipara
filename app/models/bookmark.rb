class Bookmark < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  #validatesを追加することで、重複しての登録を防ぐ
  validates :customer_id, uniqueness: { scope: :item_id }
end
