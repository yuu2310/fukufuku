class HashTag < ApplicationRecord

  validates :name, presence: true

  has_many :post_hash_tags, dependent: :destroy
end
