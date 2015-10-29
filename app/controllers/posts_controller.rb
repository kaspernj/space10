require 'instagram_api'

class PostsController < ApplicationController

	def index
		@posts = Post.published
		@instagram_photos = InstagramApi.new.photos('space10')
		@featured_tag = Settings.get['posts']['index']['featured_tag']
		@featured_posts = @posts.where_tagged_with(@featured_tag)
	end

	def show
		@post = Post.published.find(params[:id])
		@posts = Post.published.limit(3)
	end

end