class ProfileClaimsController < ApplicationController
  before_filter :signed_in_user
  layout "clean_application"

  def edit
    @profile = Profile.find_by!(claim_token: params[:id])
  end

  def update
    @profile = Profile.find_by!(claim_token: params[:id])
    if @profile.type == "PersonalProfile"
      current_user.update_attributes!(personal_profile: @profile)
      redirect_to root_path, notice: "Profile claimed!"
    else
      redirect_to root_path, notice: "Can't claim company profiles!"
    end
  end
end
