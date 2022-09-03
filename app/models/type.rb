class Type < ApplicationRecord


  has_many :categories, dependent: :destroy
end
