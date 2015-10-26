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
					'starts_at' => event.starts_at.in_time_zone('Copenhagen').to_s(:formatted),
					'ends_at' => event.ends_at.in_time_zone('Copenhagen').to_s(:formatted),
					'published_at' => event.published_at.in_time_zone('Copenhagen').to_s(:formatted)
				}
			)
		end
	end

end