class PressMentionsController < ApplicationController
  def index
    @mentions = PressMention.published
  end
end