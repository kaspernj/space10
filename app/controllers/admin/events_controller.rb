class Admin::EventsController < AdminController

	def show
		@event  =Event.find(params[:id])	
	end

	def new
		@event = Event.new
		@event.build_address
	end

	def create
		@event = Event.new(event_params)

		if @event.save
			flash[:success] = "Event created successfully"
			redirect_to edit_admin_event_path @event
		else
			render 'new'
		end
	end

	def index
		@events = Event.all
	end

	def edit
		@event = Event.find(params[:id])
		@event.build_address() if @event.address.blank?
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			flash[:success] = "Event updated"
			redirect_to edit_admin_event_path @event
		else
			render 'edit'
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to admin_events_path, notice: "Event deleted"
	end

private

	def event_params
		return_params = params.require(:event).permit(:title, :published, :publish_at, :excerpt, :content, :starts_at, :ends_at, :max_registrations, :address_id, address_attributes: [:id, :name, :address_1, :address_2, :zipcode, :city, :country], image_attachments_attributes: [:id, :resource_type, :resource_id, :image, :image_cache, :row_order, :_destroy] )

		if params[:commit].downcase == "publish now"
			return_params[:published] = true
			return_params[:publish_at] = DateTime.now.to_s(:formatted)
		elsif params[:commit].downcase == "schedule"
			return_params[:published] = true
		end

		return_params
	end
end
