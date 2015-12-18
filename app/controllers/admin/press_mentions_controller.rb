class Admin::PressMentionsController < AdminController

  def index
    @press_mentions = PressMention.all
  end

  def new
    @press_mention = PressMention.new
  end

  def create
    @press_mention = PressMention.new(press_mention_params)
    if @press_mention.save
      flash[:succes] = "Press mention created"
      redirect_to admin_press_mentions_path
    else
      render :new
    end
  end

  def edit
    @press_mention = PressMention.find(params[:id])
  end

  def update
    @press_mention = PressMention.find(params[:id])
    if @press_mention.update(press_mention_params)
      flash[:success] = "Press mention updated"
      redirect_to edit_admin_press_mention_path(@press_mention)
    else
      render :edit
    end
  end

  def destroy
    @press_mention = PressMention.find(params[:id])
    @press_mention.destroy
    redirect_to admin_press_mentions_path, notice: "Mention destroyed"
  end

private

  def press_mention_params
    params.require(:press_mention).permit(:title, :destription, :source, :url, :published_at, :published, :featured, :image, :image_cache)
  end
end