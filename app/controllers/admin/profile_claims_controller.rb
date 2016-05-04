class Admin::ProfileClaimsController < AdminController
  before_filter :only_personal_profiles, only: :create

  def create
    @profile = Profile.find(params[:profile_id])
    @profile.generate_claim_token if @profile
    redirect_to admin_profile_claim_path(@profile)
  end

  def show
    @profile = Profile.find(params[:id])
  end

private

  def only_personal_profiles
    profile = Profile.find(params[:profile_id])
    unless profile.type == "PersonalProfile"
      redirect_to admin_profiles_path, notice: "Can't generate link for company profiles. Yet..."
    end
  end
end
