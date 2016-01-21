class Api::V1::TagsController < Api::V1::ApiController
  before_filter :authenticate_api_client

  def profile_tags
    @tags = ProfileTag.all
  end

  def post_tags
    @tags = PostTag.all
  end

end