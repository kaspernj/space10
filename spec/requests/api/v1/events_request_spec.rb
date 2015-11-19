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
					'content' => event.content,
					'featured_image' => nil,
					'secondary_image' => nil,
					'starts_at' => event.starts_at.in_time_zone('Copenhagen').iso8601,
					'ends_at' => event.ends_at.in_time_zone('Copenhagen').iso8601,
					'published_at' => event.published_at.in_time_zone('Copenhagen').iso8601
				}
			)
		end
	end

end