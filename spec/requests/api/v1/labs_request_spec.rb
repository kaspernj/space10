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
          'ends_at' => lab.ends_at.in_time_zone('Copenhagen').iso8601,
          'events' => [],
          'posts' => [
            {
              'id' => post.id,
              'excerpt' => post.excerpt,
              'title' => post.title,
              'featured_image'  => {
                  'small' => post.featured_image_url(:small),
                  'medium' => post.featured_image_url(:medium),
                  'large' => post.featured_image_url(:large)
                },
              'tags' => [],
              'content' => post.content,
              'published_at' => post.published_at.in_time_zone('Copenhagen').iso8601,
              'project_partners' => {
                'text' => nil,
                'partners' => [],
              },
              'project_people' => {
                'text' => nil,
                'people' => [],
              },
              'lab' => {
                'id' => lab.id,
                'title' => lab.title,
                'subtitle' => lab.subtitle
              }
            }
          ]
        }
      )
    end
  end

end