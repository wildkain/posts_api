class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  has_secure_password

  validates :nickname, presence: true
  validates :email, presence: true
end
