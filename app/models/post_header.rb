class PostHeader < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_details, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy

  accepts_nested_attributes_for :post_details, allow_destroy: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end



  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_user.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
