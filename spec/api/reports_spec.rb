require 'rails_helper'

describe  "Reports API" do
  describe "POST /reports/by_author" do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let (:user) { create :user }
      let! (:access_token) {  JwtService.encode( { user_id: user.id, exp: 24.hours.from_now.to_i} ) }
      let!(:start_date) { "2018-08-04 09:49:06" }
      let!(:end_date ) { "2018-09-04 09:49:06" }
      let!(:email) { user.email }
      let!(:message) { { "message": "Report generation started" } }


      it 'return success message' do
        post '/api/v1/reports/by_author.json',
             headers:  {"Authorization" =>"Bearer #{access_token}"},
             params: { format: :json, start_date: start_date, end_date: end_date, email: email}
        expect(response.body).to be_json_eql(message.to_json)
      end

      it 'should invoke report job' do
        expect(ReportGeneratorJob).to receive(:perform_later).with(start_date, end_date, email)
        post '/api/v1/reports/by_author.json',
             headers:  {"Authorization" =>"Bearer #{access_token}"},
             params: { format: :json, start_date: start_date, end_date: end_date, email: email}

        expect(response.body).to include('{"message":"Report generation started"}')
      end

    end

    def do_request(options = {})
      post '/api/v1/reports/by_author.json', params: { format: :json}.merge(options)
    end
  end
end
