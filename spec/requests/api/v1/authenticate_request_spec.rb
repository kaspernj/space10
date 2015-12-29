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
			expect(response_body).to eq(
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
			)
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