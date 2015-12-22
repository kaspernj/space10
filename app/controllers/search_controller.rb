class SearchController < ApplicationController

  def search
    respond_to do |format|
      format.js
    end
  end

  def search_results
    @search_results = PgSearch.multisearch(params[:search][:query]).with_pg_search_rank.map(&:searchable)
    @search_results.reject!{|s| !s.published? || s.publish_at > Time.zone.now }
    if params[:search][:sort_by] == 'recent'
      @search_results.sort!{|a,b| b.publish_at <=> a.publish_at} if @search_results.any?
    end
    respond_to do |format|
      format.js
    end
  end
end