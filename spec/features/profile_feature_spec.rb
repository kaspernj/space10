require "rails_helper"

RSpec.describe "Profile feature", type: :feature do
	let(:user) { create :user }
	let(:admin) { create :user, admin: true }

	describe "profile creation" do
		before :each do
			sign_in admin
			visit new_admin_profile_path
		end

		it "should allow admins to create company profiles" do
			select "Company", from: "Profile type"
			fill_in "Full name", with: "Lucas Films inc."
			fill_in "Description", with: "A film production company"
			fill_in "Location", with: "Los Angeles, California"

			page.attach_file "profile[image]", Rails.root + "spec/factories/images/image_1.jpg"

			check "Publish"
			click_on "Create profile"

			expect(page).to have_content("Profile created")

			expect(Profile.last.title).to eq("Lucas Films inc.")
			expect(Profile.last.type).to eq("CompanyProfile")
		end
	end

	describe "claiming profiles" do
		let(:personal_profile) { create :personal_profile }
		let(:company_profile) { create :company_profile }

		describe "personal profiles" do
			it "creates a claim link" do
				personal_profile
				sign_in admin
				visit admin_profiles_path
				within "#profile_#{personal_profile.id}" do
					find(".fa-hand-grab-o").find(:xpath, ".//..").click
				end
				expect(current_path).to eq admin_profile_claim_path(personal_profile)
				expect(personal_profile.reload.claim_token).not_to be_nil
				expect(page).to have_content(personal_profile.claim_token)
			end

			context "signed in" do
				it "allows claiming" do
					personal_profile.generate_claim_token
					sign_in user
					visit edit_profile_claim_path(personal_profile.reload.claim_token)
					expect(page).to have_content personal_profile.title
					click_on "Claim profile"

					expect(current_path).to eq root_path
					expect(user.reload.personal_profile).to eq personal_profile
				end
			end

			context "not signed in" do
				it "prompts sign in" do
					personal_profile.generate_claim_token
					visit edit_profile_claim_path(personal_profile.reload.claim_token)
					expect(current_path).to eq new_user_path
				end
			end
		end

		describe "company profiles" do
			it "doesnt allow creating claim links" do
				company_profile
				sign_in admin
				visit admin_profiles_path
				within "#profile_#{company_profile.id}" do
					find(".fa-hand-grab-o").find(:xpath, ".//..").click
				end
				expect(current_path).to eq admin_profiles_path
				expect(page).to have_content("Can't generate link for company profiles. Yet...")
			end
		end
	end
end
