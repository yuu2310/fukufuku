class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true
  validates :email, presence: true
  validates :height, presence: true
  validates :sex, presence: true
  validates :is_deleted, presence: true

  # フォローする側から中間テーブルへのアソシエーション
  has_many :relationships, foreign_key: :followed_id
  # フォローする側からフォローされたユーザを取得する
  has_many :followeds, through: :relationships, source: :follower

  # フォローされる側から中間テーブルへのアソシエーション
  # フォローする側からのアソシエーションと重複してしまうためreverse_of_relationshipsと記述する
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  # フォローされる側からフォローしているユーザを取得する
  has_many :followers, through: :reverse_of_relationships, source: :followed

  # あるユーザが引数で渡されたuserにフォローされているか調べるメソッド
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end


  has_many :posts, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_user.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: size).processed
  end
end

