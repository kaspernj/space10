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

			expect(response.status).to eq 200 # created
			expect(response_body).to eq (
				{
					'id' => User.last.id,
					'auth_token' => User.last.auth_token,
					'name' => 'John',
					'email' => 'johndoe@example.com'
				}
			)
		end
	end

	describe "GET /api/user" do
		it "should return authenticated user" do
			user = create(:user)
			get '/api/user', {}, request_headers(user: user)

			expect(response.status).to eq 200 # ok
			expect(response_body).to eq(
				{
					'id' => user.id,
					'auth_token' => user.auth_token,
					'name' => user.name,
					'email' => user.email,
					'personal_profile' => [],
					'company_profiles' => []
				}
			)
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
			expect(response_body).to eq(
				{
					'id' => @user.id,
					'auth_token' => @user.auth_token,
					'name' => 'Frank',
					'email' => @user.email
				}
			)
		end

		it "should not update user if unauthorized" do
			put '/api/user', @user_params, request_headers

			expect(response.status).to eq 401
		end
	end

end