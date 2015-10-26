class Api::V1::PostsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index
		@posts = Post.published
	end

	def show
		@post = Post.published.find(params[:id])
		@posts = Post.published.limit(3)
		respond_to do |format|
	    format.html { render 'posts/show' }
	    format.json { @post }
	  end
	end
end