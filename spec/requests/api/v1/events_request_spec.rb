require "rails_helper"

describe "Events api", type: :request do

	describe "GET /api/events" do
		it "should return all events" do
			create :event, title: "Great Talk"
			create :event, title: "Awesome workshop"

			get '/api/events', {}, request_headers

			expect(response.status).to eq 200

			event_titles = response_body.map{ |m| m['title'] }
			expect(event_titles).to eq(["Great Talk", "Awesome workshop"])
		end
	end

	describe "GET /api/events/future" do
		it "should return all future events" do
			create :event, title: "Great Talk", starts_at: 2.days.ago.to_s(:formatted), ends_at: 1.day.ago.to_s(:formatted)
			create :event, title: "Awesome workshop"

			get '/api/future_events', {}, request_headers

			expect(response.status).to eq 200

			event_titles = response_body.map{ |m| m['title'] }
			expect(event_titles).to eq(["Awesome workshop"])
		end
	end

	describe "GET /api/events/historic" do
		it "should return all historic events" do
			create :event, title: "Great Talk", starts_at: 2.days.ago.to_s(:formatted), ends_at: 1.day.ago.to_s(:formatted)
			create :event, title: "Awesome workshop"

			get '/api/historic_events', {}, request_headers

			expect(response.status).to eq 200

			event_titles = response_body.map{ |m| m['title'] }
			expect(event_titles).to eq(["Great Talk"])
		end
	end

	describe "GET /api/events/:id" do
		it "should return requested event" do
			event = create(:event)

			get "/api/events/#{event.id}", {}, request_headers

			expect(response.status).to eq 200
			expect(response_body).to eq (
				{
					'id' => event.id,
					'title' => event.title,
					'excerpt' => event.excerpt,
					'address' => event.address,
					'content' => event.content,
					'content_blocks' => [],
					'featured_image' => {
							'small' => event.featured_image_url(:small),
							'medium' => event.featured_image_url(:medium),
							'large' => event.featured_image_url(:large)
						},
					'secondary_image' => {
							'small' => event.secondary_image_url(:small),
							'medium' => event.secondary_image_url(:medium),
							'large' => event.secondary_image_url(:large)
						},
					'starts_at' => event.starts_at.in_time_zone('Copenhagen').iso8601,
					'ends_at' => event.ends_at.in_time_zone('Copenhagen').iso8601,
					'published_at' => event.published_at.in_time_zone('Copenhagen').iso8601,
					'project_partners' => {
						'text' => nil,
						'partners' => [],
					},
					'project_people' => {
						'text' => nil,
						'people' => [],
					},
					'lab' => nil
				}
			)
		end
	end

	describe "GET /api/events/:id with token set" do
		it "should include confirmtion status in response" do
			user = create(:user)
			event = create(:event)

			get "/api/events/#{event.id}", {}, request_headers(user: user)

			expect(response.status).to eq 200
			expect(response_body['confirmation_status']).to eq 'no_request'
		end

		it "should include confirmtion status in response on requested seats" do
			user = create(:user)
			event = create(:event)
			create :registration, user: user, event: event

			get "/api/events/#{event.id}", {}, request_headers(user: user)

			expect(response.status).to eq 200
			expect(response_body['confirmation_status']).to eq 'unconfirmed'
		end
	end

end