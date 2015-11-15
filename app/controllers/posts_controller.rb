require 'instagram_api'

class PostsController < ApplicationController

	def index
		@posts = Post.published
		@instagram_photos = InstagramApi.new.user_photos('214647329')
		
		@featured_lab = Settings.get['posts']['index']['featured_tag']
		
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
					@featured_posts = featured_posts
			end
			@featured_posts_count = @featured_posts.count
		end
	end

	def show
		@post = Post.published.find(params[:id])
		@posts = Post.published.limit(3)
	end

end