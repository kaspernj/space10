class Admin::PostsController < AdminController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:success] = "Post created successfully"
			redirect_to admin_posts_path
		else
			render 'new'
		end
	end

	def index
		@posts = Post.all.order('updated_at DESC')
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			flash[:success] = "Post updated"
			redirect_to edit_admin_post_path(@post)
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to admin_posts_path, notice: "Post deleted"
	end

	private

	def post_params
		content_block = :id, :type, :title, :description, :resource_type, :resource_id, :row_order, :_destroy
		image_attachment = :id, :resource_type, :resource_id, :title, :description, :image, :image_cache, :row_order, :_destroy
		text_attachment = :id, :resource_type, :resource_id, :content
		video_attachment = :id, :resource_type, :resource_id, :featured, :title, :description, :video_url, :provider, :video_id, :image
		quote_attachment = :id, :resource_type, :resource_id, :quote, :author
		project_partnership = :id, :resource_type, :resource_id, :partner_id, :person_id, :_destroy

		return_params = params.require(:post).permit(:title, :excerpt, :tag_tokens, :content, :rateable, :published, :publish_at, :lab_id, :project_partners_text, :project_people_text, image_attachments_attributes: [image_attachment],
			content_blocks_attributes: [content_block, 
				image_attachments_attributes: [image_attachment], 
				image_attachment_attributes: [image_attachment],
				text_attachment_attributes: [text_attachment],
				video_attachment_attributes: [video_attachment],
				quote_attachment_attributes: [quote_attachment]
				],
			image_slider_blocks_attributes: [content_block, image_attachments_attributes: [image_attachment]], 
			image_blocks_attributes: [content_block, image_attachment_attributes: [image_attachment]],
			text_blocks_attributes: [content_block, text_attachment_attributes: [text_attachment]],
			video_blocks_attributes: [content_block, video_attachment_attributes: [video_attachment]],
			quote_blocks_attributes: [content_block, quote_attachment_attributes: [quote_attachment]],
			company_partnerships_attributes: [project_partnership],
			person_partnerships_attributes: [project_partnership]
			)
		
		if params[:commit].downcase == "publish now"
			return_params[:published] = true
			return_params[:publish_at] = Time.zone.now.to_s(:formatted)
		elsif params[:commit].downcase == "schedule"
			return_params[:published] = true
		end

		return_params
	end

end