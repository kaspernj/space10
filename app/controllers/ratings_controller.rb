class RatingsController < ApplicationController
  before_filter :signed_in_user
  before_filter :find_rateable, only: :create

  def create
    @rating = @rateable.ratings.new(rating_params)
    if @rating.save
      respond_to do |format|
        format.html { redirect_to @rateable }
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def edit
    @rating = Rating.find(params[:id])
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(rating_params)
      respond_to do |format|
        format.html { redirect_to rating.resource }
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

private

  def rating_params
    params.require(:rating).permit(:content, :score, :resource_type, :resource_id).merge(user_id: current_user.id)
  end

  def find_rateable
    @rateable = retrieve_rateable_from_params
  end

  def retrieve_rateable_from_params
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end