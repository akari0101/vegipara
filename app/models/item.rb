class Item < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}

  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

  def taxin_price
    price*1.1
  end

  #消費税を加えた商品価格
  def add_tax_price
    (self.price * 1.10).round
  end
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
