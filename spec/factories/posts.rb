FactoryBot.define do
  factory :post do
    title "Tst title"
    body "Tst string"
    author nil
    published_at Time.now
  end
end
