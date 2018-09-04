require 'rails_helper'

RSpec.describe AvatarsController, type: :controller do
  let!(:user) { create :user }
  let!(:access_token) {  JwtService.encode( { user_id: user.id, exp: 24.hours.from_now.to_i} ) }
  let(:params) { { token: access_token } }

  describe "GET #show" do

    context "Authorized" do
      it "returns http success" do
        get :show, params: params
        expect(response).to have_http_status(:success)
      end
    end

    context "Not-authorized" do
      it "returns :unauthorized error" do
        get :show, params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #create" do

    context "NOT - Authorized" do
      it "returns http success" do
        post :create, params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

      context "Authorized" do
      it "returns http success" do
        post :create, params: { token: access_token, user: { avatar: nil } }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
