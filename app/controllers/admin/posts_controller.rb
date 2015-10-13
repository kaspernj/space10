class Admin::PostsController < AdminController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:success] = "Post created"
			redirect_to admin_posts_path
		else
			render 'new'
		end
	end

	def index
		@posts = Post.all
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
		
	end

	private

	def post_params
		content_block = :id, :type, :resource_type, :resource_id, :row_order
		image_attachment = :id, :resource_type, :resource_id, :image, :image_cache, :row_order, :_destroy
		text_attachment = :id, :resource_type, :resource_id, :content
		video_attachment = :id, :resource_type, :resource_id, :title, :video_url, :provider, :video_id
		params.require(:post).permit(:title, :excerpt,
			content_blocks_attributes: [content_block, 
				image_attachments_attributes: [image_attachment], 
				image_attachment_attributes: [image_attachment],
				text_attachment_attributes: [text_attachment],
				video_attachment_attributes: [video_attachment]
				],
			image_slider_blocks_attributes: [content_block, image_attachments_attributes: [image_attachment]], 
			image_blocks_attributes: [content_block, image_attachment_attributes: [image_attachment]],
			text_blocks_attributes: [content_block, text_attachment_attributes: [text_attachment]],
			video_blocks_attributes: [content_block, video_attachment_attributes: [video_attachment]]
			)
	end

end