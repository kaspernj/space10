class Admin::TagsController < AdminController

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:succes] = "Tag created"
      redirect_to admin_tags_path
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:success] = "Tag updated"
      redirect_to edit_admin_tag_path(@tag)
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tags_path, notice: "Tag destroyed"
  end

private

  def tag_params
    params.require(:tag).permit(:title)
  end
end