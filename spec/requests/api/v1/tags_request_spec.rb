require "rails_helper"

describe "Tags", type: :request do

  describe "GET /api/profile_tags" do
    it "should return all profile tags" do
      profile_tag_1 = create :profile_tag, title: "Great profile_tag"
      profile_tag_2 = create :profile_tag, title: "Awesome profile_tag"
      post_tag_2 = create :post_tag, title: "Awesome post_tag"

      get '/api/profile_tags', {}, request_headers

      expect(response.status).to eq 200
      expect(response_body).to eq([
          {
            "id" => profile_tag_1.id,
            "title" => profile_tag_1.title,
          },
          {
            "id" => profile_tag_2.id,
            "title" => profile_tag_2.title,
          }
        ])
    end
  end

  describe "GET /api/post_tags" do
    it "should return all post tags" do
      post_tag_1 = create :post_tag, title: "Great post_tag"
      post_tag_2 = create :post_tag, title: "Awesome post_tag"
      profile_tag_2 = create :profile_tag, title: "Awesome profile_tag"

      get '/api/post_tags', {}, request_headers

      expect(response.status).to eq 200
      expect(response_body).to eq([
          {
            "id" => post_tag_1.id,
            "title" => post_tag_1.title,
          },
          {
            "id" => post_tag_2.id,
            "title" => post_tag_2.title,
          }
        ])
    end
  end

end