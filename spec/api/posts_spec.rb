require 'rails_helper'


describe  "Posts API" do
  let (:user) { create :user }
  let! (:access_token) {  JwtService.encode( { user_id: user.id, exp: 24.hours.from_now.to_i} ) }

  describe "GET index /api/v1/posts" do
   it_behaves_like "API Authenticable"

    context 'authorized' do
      let (:user) { create :user }
      let! (:access_token) {  JwtService.encode( { user_id: user.id, exp: 24.hours.from_now.to_i} ) }
      let!(:posts) { create_list(:post, 5, author: user)}
      let!(:post) { posts.first }

      it_behaves_like "API successful response"

      before { do_request_with_auth }

      it 'returns posts collection' do
        expect(response.body).to have_json_size(5)
      end

      %w[id title body published_at].each do |attr|
        it "post object contains #{attr}" do
          expect(response.body).to be_json_eql(post.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end

      def do_request(options = {})
        get '/api/v1/posts.json', params: { format: :json}.merge(options)
      end

      def do_request_with_auth(options = {})
       get '/api/v1/posts.json', headers:  {"Authorization" =>"Bearer #{access_token}"},  params: { format: :json }.merge(options)
      end
  end

  describe "GET show api/v1/posts/:id" do
    let!(:post) { create(:post, author: user)}
    it_behaves_like "API Authenticable"

    context "Authorized"  do

      before { get "/api/v1/posts/#{post.id}.json", headers:  {"Authorization" =>"Bearer #{access_token}"}, params: { format: :json } }

      %w[id title body published_at ].each do | attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(post.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end

      it 'contains author nickname' do
        expect(response.body).to be_json_eql(post.author.nickname.to_json).at_path("author_nickname")
      end

    end

    def do_request(*options)
      get "/api/v1/posts/#{post.id}.json", params: { format: :json }
    end

  end

  describe "POST create /api/v1/posts" do

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let!(:user) { create :user }
      let! (:access_token) {  JwtService.encode( { user_id: user.id, exp: 24.hours.from_now.to_i} ) }
      let(:params) {{ post: attributes_for(:post, author: user) }}


       it 'creates new post' do
          expect{ do_request(params, {"Authorization" =>"Bearer #{access_token}"})}.to change {Post.count}.by(1)
       end

        %w[title body].each do |attr|
          it "response object contains #{attr}" do
            do_request(params, {"Authorization" =>"Bearer #{access_token}"})
            expect(response.body).to be_json_eql(params[:post][attr.to_sym].to_json).at_path("#{attr}")
          end
        end

        it 'contains author nickname' do
          do_request(params, {"Authorization" =>"Bearer #{access_token}"})
          expect(response.body).to be_json_eql(user.nickname.to_json).at_path("author_nickname")
        end
    end

    def do_request(options = {}, headers ={})
      post '/api/v1/posts.json', headers: {}.merge(headers), params: { format: :json}.merge(options)
    end
  end
end
