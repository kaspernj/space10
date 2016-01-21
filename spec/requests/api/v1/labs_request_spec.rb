require "rails_helper"

describe "Labs api", type: :request do

  describe "GET /api/labs" do
    it "should return all labs" do
      lab1 = create :lab, title: "Great Lab"
      lab2 = create :lab, title: "Awesome Lab"

      create(:post, lab: lab1)

      get '/api/labs', {}, request_headers

      expect(response.status).to eq 200

      event_titles = response_body.map{ |m| m['title'] }
      expect(event_titles).to eq(["Great Lab", "Awesome Lab"])
    end
  end

  describe "GET /api/labs/:id" do
    it "should return requested lab" do
      lab = create(:lab, title: "Great Lab")
      post = create(:post, lab: lab)

      get "/api/labs/#{lab.id}", {}, request_headers

      expect(response.status).to eq 200
      expect(response_body).to eq (
        {
          'id' => lab.id,
          'title' => lab.title,
          'subtitle' => lab.subtitle,
          'starts_at' => lab.starts_at.in_time_zone('Copenhagen').iso8601,
          'ends_at' => lab.ends_at.in_time_zone('Copenhagen').iso8601
        }
      )
    end
  end

  describe "GET /api/labs/:id/posts" do
    it "should return requested lab posts" do
      lab = create(:lab, title: "Great Lab")
      post_1 = create(:post, lab: lab, title: "Great Talk")
      post_2 = create(:post, lab: nil, title: "Not much")

      get "/api/labs/#{lab.id}/posts", {}, request_headers

      expect(response.status).to eq 200

      post_titles = response_body.map{ |m| m['title'] }
      expect(post_titles).to eq(["Great Talk"])
    end
  end

  describe "GET /api/labs/:id/future_events" do
    it "should return requested lab future events" do
      lab = create(:lab, title: "Great Lab")
      event_1 = create(:event, lab: nil, title: "Awesome", starts_at: 2.days.from_now.to_s(:formatted))
      event_2 = create(:event, lab: lab, title: "Great", starts_at: 2.days.ago.to_s(:formatted), ends_at: 1.day.ago.to_s(:formatted))
      event_3 = create(:event, lab: lab, title: "Beautiful", starts_at: 2.days.from_now.to_s(:formatted))

      get "/api/labs/#{lab.id}/future_events", {}, request_headers

      expect(response.status).to eq 200

      post_titles = response_body.map{ |m| m['title'] }
      expect(post_titles).to eq(["Beautiful"])
    end
  end

  describe "GET /api/labs/:id/historic_events" do
    it "should return requested lab historic events" do
      lab = create(:lab, title: "Great Lab")
      event_1 = create(:event, lab: nil, title: "Awesome", starts_at: 2.days.from_now.to_s(:formatted))
      event_2 = create(:event, lab: lab, title: "Great", starts_at: 2.days.ago.to_s(:formatted), ends_at: 1.day.ago.to_s(:formatted))
      event_3 = create(:event, lab: lab, title: "Beautiful", starts_at: 2.days.from_now.to_s(:formatted))

      get "/api/labs/#{lab.id}/historic_events", {}, request_headers

      expect(response.status).to eq 200

      post_titles = response_body.map{ |m| m['title'] }
      expect(post_titles).to eq(["Great"])
    end
  end

end