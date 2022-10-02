class PostCategory < ApplicationRecord

  belongs_to :post_header
  belongs_to :category
  
end
