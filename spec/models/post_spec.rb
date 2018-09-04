require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should belong_to(:author) }

  describe ".prepare_report" do
    it 'should create valid data' do
      user1 = create(:user, nickname: 'Nick', email: 'nick@gmail.com')
      user2 = create(:user, nickname: 'Mick', email: 'mick@gmail.com')
      create_list(:post, 3, author: user1)
      create_list(:post, 2, author: user2)

      report = Post.prepare_report(Time.now - 1.day, Time.now + 1.day)
      expect(report.keys.size).to eq 2
      expect(report[['Nick', 'nick@gmail.com']]).to eq 3
      expect(report[['Mick', 'mick@gmail.com']]).to eq 2
    end
  end

end
