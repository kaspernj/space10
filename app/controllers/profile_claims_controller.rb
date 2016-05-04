class ProfileClaimsController < ApplicationController
  before_filter :signed_in_user
  layout "clean_application"

  def edit
    @profile = Profile.find_by!(claim_token: params[:id])
  end

  def update
    @profile = Profile.find_by!(claim_token: params[:id])
    current_user.update_attributes!(personal_profile: @profile)
    redirect_to root_path, notice: "Profile claimed!"
  end
end
