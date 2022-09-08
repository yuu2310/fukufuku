class Category < ApplicationRecord

  belongs_to :type
  has_many :post_details, dependent: :destroy
  has_many :post_categories, dependent: :destroy

  validates :category_name, presence: true
  validates :type_id, presence: true


end
