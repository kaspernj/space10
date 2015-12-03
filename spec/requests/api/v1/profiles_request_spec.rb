require "rails_helper"

describe "profiles api", type: :request do

	describe "GET /api/profiles" do
		let!(:profile_one ) { create(:profile, title: "Company 1", type: 'CompanyProfile', location: 'Copenhagen, Denmark' )}
		let!(:profile_two) 	{ create(:profile, title: "Company 2", type: 'CompanyProfile', location: 'Berlin, Germany' )}

		it "should return all profiles" do
			get '/api/profiles', {}, request_headers

			expect(response.status).to eq 200

			expect(response_body['profiles_count']).to eq(2)
			profile_titles = response_body['profiles'].map{ |m| m['title'] }
			expect(profile_titles).to eq(["Company 1", "Company 2"])
		end

		it "should return all profiles based on category" do
			tag = profile_one.tags.create! title: 'Tag on'

			get "/api/profiles?category=#{tag.title}", {}, request_headers

			expect(response.status).to eq 200

			expect(response_body['profiles_count']).to eq(1)
			profile_titles = response_body['profiles'].map{ |m| m['title'] }
			expect(profile_titles).to eq(["Company 1"])
		end

		it "should return all profiles based on location" do
			tag = profile_one.tags.create! title: 'Tag on'

			get "/api/profiles?location=#{profile_two.location}", {}, request_headers

			expect(response.status).to eq 200

			expect(response_body['profiles_count']).to eq(1)
			profile_titles = response_body['profiles'].map{ |m| m['title'] }
			expect(profile_titles).to eq(["Company 2"])
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

	describe "GET /api/profiles/filter_options" do
		it "should return filter options" do
			create :tag, title: "Tag one"
			create :tag, title: "Tag two"
			create :profile, title: "Company 1", type: "CompanyProfile", location: 'Copenhagen, Denmark'

			get '/api/profiles/filter_options', {}, request_headers

			expect(response.status).to eq 200
			expect(response_body).to eq (
				{
					'categories' => ['Tag one', 'Tag two'],
					'locations' => ['Copenhagen, Denmark']
				}
			)
		end
	end
end