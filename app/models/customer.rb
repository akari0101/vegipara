class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def self.guest
    find_or_create_by!(first_name: 'guestcustomer', email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.first_name = "guestcustomer"
      customer.last_name = "guest"
      customer.kana_last_name = "guest"
      customer.kana_first_name = "guest"
      customer.post_code = "guest"
      customer.address = "guest"
      customer.phone_number = "guest"
      customer.email = "guest@example.com"
    end
  end
end
