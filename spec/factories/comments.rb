FactoryBot.define do
  factory :comment do
    body "comment Body"
    post nil
    author nil
    published_at Time.now
  end
end
