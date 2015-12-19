require 'instagram_api'

class PostsController < ApplicationController

	def index
		if params[:last_post]
			last_post = params[:last_post].to_i
			@posts = Post.published.offset(last_post).limit(3)
			@last_post = last_post + 3
		else
			@posts = Post.published.limit(13)
		end

		@instagram_photos = InstagramApi.new.user_photos('2179243523')
		
		@featured_lab = Settings.get['posts']['index']['featured_tag']
		@featured_videos = VideoAttachment.featured.includes(:resource).limit(4)
		@mentions = PressMention.published.featured.limit(8)
		
		featured_posts = @posts.where_tagged_with(@featured_lab)

		if featured_posts
			featured_posts_count = featured_posts.count
			case
				when featured_posts_count > 6
					@featured_posts = featured_posts.limit(6)
				when featured_posts_count == 5
					@featured_posts = featured_posts.limit(4)
				when featured_posts_count < 3
					@featured_posts = []
				else
					@featured_posts = featured_posts.includes(:lab)
			end
			@featured_posts_count = @featured_posts.count
		end

		prepare_meta_tags(title: "Journal")

		respond_to do |format|
      format.html
      format.js
    end
	end

	def show
		@post = Post.published.find(params[:id])
		if params[:last_post]
			last_post = params[:last_post].to_i
			@posts = Post.published.offset(last_post).limit(3)
			@last_post = last_post + 3
		else
			@posts = Post.published.limit(3)
		end

		prepare_meta_tags(title: @post.title,
                      description: @post.excerpt,
                      image: @post.featured_image_url(:large),
                      keywords: @post.tags.pluck(:title),
                      type: 'article',
                      twitter: {card: "summary_large_image"})

		respond_to do |format|
      format.html
      format.js
    end
	end

end