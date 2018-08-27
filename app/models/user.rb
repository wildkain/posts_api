class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_secure_password
  validates :nickname, presence: true
  validates :email, presence: true
end
