require 'rails_helper'

describe "Posts api", type: :request do

	describe "GET /api/posts" do
		it 'returns all posts' do
			post1 = create :post, title: "Great Talk"
			post2 = create :post, title: "Awesome workshop"

			get '/api/posts', {}, request_headers

			expect(response.status).to eq 200

			post_titles = response_body.map{ |m| m['title'] }
			expect(post_titles).to eq(["Great Talk", "Awesome workshop"])
		end
	end

	describe "GET /api/posts/:id" do
		it 'returns requested post' do
			post = create(:post, lab: nil, images_count: 1)
			img_block = create :image_block, resource: post, row_order: 1
			txt_block = create :text_block, resource: post, row_order: 2
			img_slider_block = create :image_slider_block, resource: post, row_order: 3
			vid_block = create :video_block, resource: post, row_order: 4
			qut_block = create :quote_block, resource: post, row_order: 5

			get "/api/posts/#{post.id}", {}, request_headers

			expect(response.status).to eq 200
			expect(response_body).to eq (
				{
					'id' => post.id,
					'excerpt' => post.excerpt,
					'title' => post.title,
					'featured_image'  => {
												'small' => post.featured_image_url(:small),
												'medium' => post.featured_image_url(:medium),
												'large' => post.featured_image_url(:large)
											},
					'featured_images'  => [{
												'small' => post.featured_image_url(:small),
												'medium' => post.featured_image_url(:medium),
												'large' => post.featured_image_url(:large)
											}],
					'tags' => [],
					'content' => post.content,
					'content_blocks' => [
							{
								'id' => img_block.id,
								'type' => 'ImageBlock',
								'row_order' => 1,
								'content' => {
									'title' => img_block.image_attachment.title,
									'description' => img_block.image_attachment.description,
									'image' => {
										'small' => img_block.image_attachment.image_url(:small),
										'medium' => img_block.image_attachment.image_url(:medium),
										'large' => img_block.image_attachment.image_url(:large)
									}
								}
							},
							{
								'id' => txt_block.id,
								'type' => 'TextBlock',
								'row_order' => 2,
								'content' => txt_block.text_attachment.content
							},
							{
								'id' => img_slider_block.id,
								'type' => 'ImageSliderBlock',
								'row_order' => 3,
								'content' => {
									'title' => img_slider_block.title,
									'description' => img_slider_block.description,
									'images' => [
										{
											'small' => img_slider_block.image_attachments.third.image_url(:small),
											'medium' => img_slider_block.image_attachments.third.image_url(:medium),
											'large' => img_slider_block.image_attachments.third.image_url(:large)
										},
										{
											'small' => img_slider_block.image_attachments.second.image_url(:small),
											'medium' => img_slider_block.image_attachments.second.image_url(:medium),
											'large' => img_slider_block.image_attachments.second.image_url(:large)
										},
										{
											'small' => img_slider_block.image_attachments.first.image_url(:small),
											'medium' => img_slider_block.image_attachments.first.image_url(:medium),
											'large' => img_slider_block.image_attachments.first.image_url(:large)
										}
									]
								}
							},
							{
								'id' => vid_block.id,
								'type' => 'VideoBlock',
								'row_order' => 4,
								'content' => {
									'title' => vid_block.video_attachment.title,
								  'description' => vid_block.video_attachment.description,
								  'video_url' => vid_block.video_attachment.video_url,
								  'provider' => vid_block.video_attachment.provider,
								  'video_id' => vid_block.video_attachment.video_id,
								  'image' => vid_block.video_attachment.image
								}
							},
							{
								'id' => qut_block.id,
								'type' => 'QuoteBlock',
								'row_order' => 5,
								'content' => {
									'quote' => qut_block.quote_attachment.quote,
									'author' => qut_block.quote_attachment.author
								}
							}
						],
					'published_at' => post.published_at.in_time_zone('Copenhagen').iso8601,
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

end