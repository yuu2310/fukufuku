class HashTag < ApplicationRecord

  validates :name, presence: true, length: { maximum: 50 }

  has_many :post_hash_tags, dependent: :destroy
  has_many :post_headers, through: :post_hash_tags
  
end
