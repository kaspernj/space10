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
			expect(response_body['title']).to eq event.title
		end
	end

end