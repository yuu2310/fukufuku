class Category < ApplicationRecord

  belongs_to :type
  has_many :post_details, dependent: :destroy

  validates :category_name, presence: true
  


end
