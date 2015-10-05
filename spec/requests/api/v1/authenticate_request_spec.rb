require "rails_helper"

describe "Authenticate api", type: :request do

	describe "POST /api/authenticate" do
		it "should return auth_token" do
			password = "foobar123"
			user = create(:user, password: password, password_confirmation: password)
			credentials = {
				"email" => user.email,
				"password" => password
			}.to_json

			post '/api/authenticate', credentials, request_headers

			expect(response.status).to eq 200
			expect(response_body['auth_token']).to eq(user.auth_token)
		end

		it "should not return auth_token on invalid credentials" do
			password = "foobar123"
			user = create(:user, password: password, password_confirmation: password)
			credentials = {
				"email" => user.email,
				"password" => "wrongpassword"
			}.to_json

			post '/api/authenticate', credentials, request_headers

			expect(response.status).to eq 400
			expect(response_body['auth_token']).to eq nil
		end
	end

end