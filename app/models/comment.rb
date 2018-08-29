class Comment < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :post, dependent: :destroy

  validates_presence_of :body
end
