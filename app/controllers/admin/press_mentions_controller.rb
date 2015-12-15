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
    
  end

  def update
    
  end

  def destroy
    
  end

private

  def press_mention_params
    params.require(:press_mention).permit(:title, :destription, :source, :url, :image, :image_cache)
  end
end