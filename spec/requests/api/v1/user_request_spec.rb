require "rails_helper"

describe "Users api", type: :request do

	describe "POST /api/users" do
		it 'allows creation of user' do
			user_params = {
				"user" => {
					"name" => "John",
					"email" => "johndoe@example.com",
					"password" => "foobar123"
				}
			}.to_json

			post '/api/users', user_params, request_headers

			expect(response.status).to eq 200 # created
			expect(response_body).to eq(
				{
					'id' => User.last.id,
					'auth_token' => User.last.auth_token,
					"name" => "John",
					"email" => "johndoe@example.com",
					'birthday' => User.last.birthday.try(:strftime,"%F"),
					'gender' => User.last.gender,
					'personal_profile' => {
						'id' => User.last.personal_profile.id,
						'type' => User.last.personal_profile.type,
						"title" => "John",
						'tagline' => User.last.personal_profile.tagline,
						'description' => nil,
						'location' => nil,
						'tags' => [],
						'avatar' => {
							'small' => User.last.personal_profile.image_url(:thumbnail),
							'medium' => User.last.personal_profile.image_url(:medium),
							'large' => User.last.personal_profile.image_url(:large)
							},
						'logo' => nil
						},
					'company_profiles' => []
				}
			)
		end
	end

	describe "POST /api/auth/facebook/callback" do
		it "allows users to signup with facebook" do
			facebook_hash = omniauth_facebook_hash.to_json

			post "/api/auth/facebook/callback", facebook_hash, request_headers

			expect(response.status).to eq 200
			expect(response_body).to eq(
				{
					'id' => User.last.id,
					'auth_token' => User.last.auth_token,
					"name" => "John Doe",
					"email" => "johndoe@example.com",
					'birthday' => User.last.birthday.try(:strftime,"%F"),
					'gender' => User.last.gender,
					'personal_profile' => {
						'id' => User.last.personal_profile.id,
						'type' => User.last.personal_profile.type,
						"title" => "John Doe",
						'tagline' => User.last.personal_profile.tagline,
						'description' => nil,
						'location' => nil,
						'tags' => [],
						'avatar' => {
							'small' => User.last.personal_profile.image_url(:thumbnail),
							'medium' => User.last.personal_profile.image_url(:medium),
							'large' => User.last.personal_profile.image_url(:large)
							},
						'logo' => nil
						},
					'company_profiles' => []
				}
			)
		end

		it "allows users to signup with linkedin" do
			linkedin_hash = omniauth_linkedin_hash.to_json

			post "/api/auth/linkedin/callback", linkedin_hash, request_headers

			expect(response.status).to eq 200
			expect(response_body).to eq(
				{
					'id' => User.last.id,
					'auth_token' => User.last.auth_token,
					"name" => "John Doe",
					"email" => "johndoe@example.com",
					'birthday' => User.last.birthday.try(:strftime,"%F"),
					'gender' => User.last.gender,
					'personal_profile' => {
						'id' => User.last.personal_profile.id,
						'type' => User.last.personal_profile.type,
						"title" => "John Doe",
						'tagline' => User.last.personal_profile.tagline,
						'description' => nil,
						'location' => nil,
						'tags' => [],
						'avatar' => {
							'small' => User.last.personal_profile.image_url(:thumbnail),
							'medium' => User.last.personal_profile.image_url(:medium),
							'large' => User.last.personal_profile.image_url(:large)
							},
						'logo' => nil
						},
					'company_profiles' => []
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
					'birthday' => user.birthday.try(:strftime,"%F"),
					'gender' => user.gender,
					'personal_profile' => {
						'id' => user.personal_profile.id,
						'type' => user.personal_profile.type,
						'title' => user.name,
						'tagline' => user.personal_profile.tagline,
						'description' => nil,
						'location' => nil,
						'tags' => [],
						'avatar' => {
							'small' => user.personal_profile.image_url(:thumbnail),
							'medium' => user.personal_profile.image_url(:medium),
							'large' => user.personal_profile.image_url(:large)
							},
						'logo' => nil
						},
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
					'name' => "Frank",
					'email' => @user.email,
					'birthday' => @user.birthday.try(:strftime,"%F"),
					'gender' => @user.gender,
					'personal_profile' => {
						'id' => @user.personal_profile.id,
						'type' => @user.personal_profile.type,
						'title' => "Frank",
						'tagline' => @user.personal_profile.tagline,
						'description' => nil,
						'location' => nil,
						'tags' => [],
						'avatar' => {
							'small' => @user.personal_profile.image_url(:thumbnail),
							'medium' => @user.personal_profile.image_url(:medium),
							'large' => @user.personal_profile.image_url(:large)
							},
						'logo' => nil
						},
					'company_profiles' => []
				}
			)
		end

		it "should not update user if unauthorized" do
			put '/api/user', @user_params, request_headers

			expect(response.status).to eq 401
		end
	end

end