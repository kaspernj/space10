class Api::V1::PostsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]
	before_filter :load_posts

	def index
		@posts = @posts.published.paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
	end

	def show
		@post = @posts.published.find(params[:id])
		@posts = @posts.published.limit(3)
		respond_to do |format|
	    format.html { render 'posts/show' }
	    format.json { @post }
	  end
	end

private

	def load_posts
		lab = Lab.find(params[:lab_id]) if params[:lab_id]
		@posts = lab ? lab.posts : Post.all
	end
end