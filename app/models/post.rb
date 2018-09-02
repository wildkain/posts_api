class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  scope :by_published_at, ->(start_date, end_date) {
    where(published_at: start_date..end_date)
  }

  scope :group_by_author, ->{
    joins(:author).group('users.nickname','users.email')
  }

  validates_presence_of :title, :body

  def self.prepare_report(start_date, end_date)
    by_published_at(start_date, end_date).group_by_author.count
  end


end
