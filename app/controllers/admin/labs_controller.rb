class Admin::LabsController < AdminController
	def new
		@lab = Lab.new
	end

	def create
		@lab = Lab.new(lab_params)
		if @lab.save
			flash[:success] = 'Lab created'
			redirect_to edit_admin_lab_path(@lab)
		else
			render 'new'
		end
	end

	def index
		@labs = Lab.order('starts_at ASC').all
	end

	def edit
		@lab = Lab.find(params[:id])
	end

	def update
		@lab = Lab.find(params[:id])
		if @lab.update(lab_params)
			flash[:success] = 'Lab updated'
			redirect_to edit_admin_lab_path(@lab)
		else
			render 'edit'
		end
	end

	private

	def lab_params
		params.require(:lab).permit(:id, :title, :subtitle, :published, :starts_at, :ends_at)
	end
end