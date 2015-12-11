class SearchController < ApplicationController
  def search
    @results = PgSearch.multisearch(params[:query])
    render json: @results
  end
end