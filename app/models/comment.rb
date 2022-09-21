class Comment < ApplicationRecord
  validates :comment, presence: true
  
  belongs_to :customer
  belongs_to :item
end
