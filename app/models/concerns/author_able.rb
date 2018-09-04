module AuthorAble
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'

    scope :group_by_author, -> {
      joins(:author).group('users.nickname', 'users.email')
    }
  end
end
