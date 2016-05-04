class Admin::ProfileClaimsController < AdminController
  def create
    profile = Profile.find(params[:profile_id])
    profile.generate_claim_token if profile
    redirect_to admin_profile_claim_path(profile)
  end

  def show
    @profile = Profile.find(params[:id])
  end
end
