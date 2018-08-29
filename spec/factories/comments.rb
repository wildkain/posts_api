FactoryBot.define do
  factory :comment do
    body
    post
    user
    published_at Time.now
  end
end
