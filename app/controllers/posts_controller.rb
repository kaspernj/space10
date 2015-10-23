require 'instagram_api'
class PostsController < ApplicationController

	def index
		@posts = Post.published
		@instagram_photos = InstagramApi.new.photos('space10')
	end

	def show
		@post = Post.published.find(params[:id])
		@posts = Post.published.limit(3)
	end

end