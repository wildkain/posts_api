class Post < ApplicationRecord
  include PublishedAble
  include AuthorAble
  has_many :comments, dependent: :destroy

  validates_presence_of :title, :body

  def self.prepare_report(start_date, end_date)
    by_published_at(start_date, end_date).group_by_author.count
  end
end
