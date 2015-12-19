class PressMentionsController < ApplicationController
  def index
    @mentions = PressMention.published.featured
  end
end