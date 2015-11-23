require "rails_helper"

describe "profiles api", type: :request do

	describe "GET /api/profiles" do
		it "should return all profiles" do
			create :profile, title: "Company 1", type: 'CompanyProfile'
			create :profile, title: "Company 2", type: 'CompanyProfile'

			get '/api/profiles', {}, request_headers

			expect(response.status).to eq 200

			profile_titles = response_body.map{ |m| m['title'] }
			expect(profile_titles).to eq(["Company 1", "Company 2"])
		end
	end

	describe "GET /api/profiles/:id" do
		it "should return requested profile" do
			profile = create(:profile, type: 'CompanyProfile')

			get "/api/profiles/#{profile.id}", {}, request_headers

			expect(response.status).to eq 200
			expect(response_body).to eq (
				{
					'id' => profile.id,
					'title' => profile.title,
					'type' => profile.type,
					'description' => profile.description,
					'location' => profile.location,
					'tags' => [],
					'avatar' => profile.image_url(:medium),
					'logo' => nil
				}
			)
		end
	end

end