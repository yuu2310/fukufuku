class Category < ApplicationRecord

  belongs_to :type
  has_many :post_details, dependent: :destroy
  has_many :post_headers, through: :post_details

  validates :category_name, presence: true

end
