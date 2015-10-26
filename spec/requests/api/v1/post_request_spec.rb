require 'rails_helper'

describe "Posts api", type: :request do

	describe "GET /api/posts" do
		it 'returns all posts' do
			create :post, title: "Great Talk"
			create :post, title: "Awesome workshop"

			get '/api/posts', {}, request_headers

			expect(response.status).to eq 200

			post_titles = response_body.map{ |m| m['title'] }
			expect(post_titles).to eq(["Great Talk", "Awesome workshop"])
		end
	end

	describe "GET /api/posts/:id" do
		it 'returns requested post' do
			post = create(:post)

			get "/api/posts/#{post.id}", {}, request_headers

			expect(response.status).to eq 200
			expect(response_body).to eq (
				{
					'id' => post.id,
					'excerpt' => post.excerpt,
					'title' => post.title,
					'content' => post.content,
					'published_at' => post.published_at.in_time_zone('Copenhagen').iso8601
				}
			)
		end
	end

end