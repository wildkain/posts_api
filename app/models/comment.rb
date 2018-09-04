class Comment < ApplicationRecord
  include PublishedAble
  include AuthorAble
  belongs_to :post, dependent: :destroy

  validates_presence_of :body

  def self.prepare_report(start_date, end_date)
    by_published_at(start_date, end_date).group_by_author.count
  end
end
