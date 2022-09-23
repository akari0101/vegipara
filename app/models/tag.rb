class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :items, through: :tagmaps
  #thoroughを使うことで、tagmaps経由でitemsにアクセスできるように
end
