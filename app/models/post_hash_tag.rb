class PostHashTag < ApplicationRecord
  validates :post_header_id, presence: true
  validates :hash_tag_id, presence: true

  belongs_to :post_header
  belongs_to :hash_tag
end
