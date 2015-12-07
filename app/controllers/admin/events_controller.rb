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
		content_block = :id, :type, :resource_type, :resource_id, :row_order, :_destroy
		image_attachment = :id, :resource_type, :resource_id, :title, :description, :image, :image_cache, :row_order, :_destroy
		text_attachment = :id, :resource_type, :resource_id, :content
		video_attachment = :id, :resource_type, :resource_id, :featured, :title, :description, :video_url, :provider, :video_id, :image
		project_partnership = :id, :resource_type, :resource_id, :partner_id, :person_id, :_destroy
		
		return_params = params.require(:event).permit(:title, :published, :publish_at, :excerpt, :content, :starts_at, :ends_at, :max_registrations, :address_id, address_attributes: [:id, :name, :address_1, :address_2, :zipcode, :city, :country], image_attachments_attributes: [:id, :resource_type, :resource_id, :image, :image_cache, :row_order, :_destroy], 
			content_blocks_attributes: [content_block, 
				image_attachments_attributes: [image_attachment], 
				image_attachment_attributes: [image_attachment],
				text_attachment_attributes: [text_attachment],
				video_attachment_attributes: [video_attachment]
				],
			image_slider_blocks_attributes: [content_block, image_attachments_attributes: [image_attachment]], 
			image_blocks_attributes: [content_block, image_attachment_attributes: [image_attachment]],
			text_blocks_attributes: [content_block, text_attachment_attributes: [text_attachment]],
			video_blocks_attributes: [content_block, video_attachment_attributes: [video_attachment]],
			company_partnerships_attributes: [project_partnership],
			person_partnerships_attributes: [project_partnership]
			)

		if params[:commit].downcase == "publish now"
			return_params[:published] = true
			return_params[:publish_at] = DateTime.now.to_s(:formatted)
		elsif params[:commit].downcase == "schedule"
			return_params[:published] = true
		end

		return_params
	end
end
