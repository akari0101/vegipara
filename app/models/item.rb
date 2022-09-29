class Item < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_many :bookmarks, dependent: :destroy
  has_one_attached :image

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {left_joins(:comments).group(:item_id).order('AVG(star) DESC')}

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

  #検索メソッド
  def self.items_serach(search)
    #タグ検索
    #文字列を一キーワードずつに変換
    word_list = search.sub(/　/," ").split(nil)
    ids = []
    # キーワードを全部検索
    word_list.each do |word|
      # タグテーブルから部分一致するタグを取得
      tag = Tag.where("tag_name LIKE ?", "%#{word}%")
      tag.each do |t|
        ids.push(t.id)
      end
    end
    # 取得したタグがついているアイテムを取得
    where(id: Tagmap.find(ids).pluck(:item_id))
  end

  def save_items(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    # Create
    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << item_tag
    end
  end

  #bookmarked_by?(customer)を追加で、既にブックマークしているかを検証
  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end
end
