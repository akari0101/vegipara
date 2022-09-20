class Item < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  
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
end
