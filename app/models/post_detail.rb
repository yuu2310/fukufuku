class PostDetail < ApplicationRecord
  
  belongs_to :post_header
  belongs_to :category
  # accepts_nested_attributes_for :grandchildren, allow: true
end
