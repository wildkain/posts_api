require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to(:author) }
  it { should belong_to(:post) }

  describe ".prepare_report" do
    it 'should create valid data' do
      user1 = create(:user, nickname: 'Nick', email: 'nick@gmail.com')
      user2 = create(:user, nickname: 'Mick', email: 'mick@gmail.com')
      post = create(:post, author: user1)
      create_list(:comment, 3, post: post, author: user1)
      create_list(:comment, 2, post: post, author: user2)
      report = Comment.prepare_report(Time.now - 1.day, Time.now + 1.day)

      expect(report.keys.size).to eq 2
      expect(report[['Nick', 'nick@gmail.com']]).to eq 3
      expect(report[['Mick', 'mick@gmail.com']]).to eq 2
    end
  end
end
