class SearchController < ApplicationController

  def search
    
  end

  def search_results
    @search_results = PgSearch.multisearch(params[:search][:query]).with_pg_search_rank.map(&:searchable)
    respond_to do |format|
      format.html
      format.js
    end
  end
end