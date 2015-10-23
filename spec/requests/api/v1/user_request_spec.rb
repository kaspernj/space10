require "rails_helper"

describe "Users api", type: :request do

	describe "POST /api/users" do
		it 'allows creation of user' do
			user_params = {
				"user" => {
					"name" => "John",
					"email" => "johndoe@example.com",
					"password" => "foobar123",
					"password_confirmation" => "foobar123"
				}
			}.to_json

			post '/api/users', user_params, request_headers

			expect(response.status).to eq 201 # created
			expect(response_body['auth_token']).to be_present
	    expect(User.first.name).to eq 'John'
		end
	end

	describe "GET /api/user" do
		it "should return authenticated user" do
			user = create(:user)
			get '/api/user', {}, request_headers(user: user)

			expect(response.status).to eq 200 # ok
			expect(response_body['name']).to eq(user.name)
		end

		it "should not return user if unauthorized" do
			user = create(:user)
			get '/api/user', {}, request_headers
			expect(response.status).to eq 401 # ok
		end
	end

	describe "PUT /api/user" do
		before :each do
			@user = create(:user, name: 'John')
			@user_params = {
				"user" => {
					"name" => "Frank"
				}
			}.to_json
		end

		it "should update authenticated user" do
			put '/api/user', @user_params, request_headers(user: @user)

			expect(response.status).to eq 200 # ok
			expect(response_body['name']).to eq('Frank')
		end

		it "should not update user if unauthorized" do
			put '/api/user', @user_params, request_headers

			expect(response.status).to eq 401
		end
	end

end