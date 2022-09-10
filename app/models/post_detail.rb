class PostDetail < ApplicationRecord

  # validates :post_header_id, presence: true
  # validates :category_id, presence: true
  # validates :size, presence: true

  belongs_to :post_header
  belongs_to :category
  # accepts_nested_attributes_for :grandchildren, allow: true
end
