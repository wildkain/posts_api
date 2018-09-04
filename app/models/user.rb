# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  validates_size_of :avatar, maximum: 3.megabytes, message: 'File size must be less then 3 Mb'

  has_secure_password

  validates :nickname, presence: true
  validates :email, presence: true
end
