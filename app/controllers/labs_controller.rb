class LabsController < ApplicationController
	def index
		@labs = Lab.published.order('starts_at, ends_at ASC')
	end

	def show
		@lab = Lab.find(params[:id])
	end

end