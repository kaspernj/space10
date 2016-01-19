class TagsController < ApplicationController
	def index
    if params['type'] == 'profile'
		  @tags = ProfileTag.all
    else
      @tags = PostTag.all
    end
		respond_to do |format|
			format.html
			format.json { render json: @tags.tokens(params[:q]) }
		end
	end
end