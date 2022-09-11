class PostHeader < ApplicationRecord
  has_one_attached :image


  validates :comment, presence: true

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_details, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_hash_tags, dependent: :destroy
  has_many :hash_tags, through: :post_hash_tags, dependent: :destroy

  accepts_nested_attributes_for :post_details, allow_destroy: true

# ログイン中のユーザーがその投稿に対していいねをしているかを判断するメソッド
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def get_image(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_user.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize: size).processed
  end
end
