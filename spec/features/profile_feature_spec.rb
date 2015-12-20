require 'rails_helper'

RSpec.describe 'Profile feature', type: :feature do
	describe 'profile creation' do
		before :each do
			user = create(:user, admin: true)
			sign_in user
			visit new_admin_profile_path
		end

		it 'should allow admins to create company profiles' do
			select 'Company', from: 'Profile type'
			fill_in 'Full name', with: 'Lucas Films inc.'
			fill_in 'Description', with: 'A film production company'
			fill_in 'Location', with: 'Los Angeles, California'

			page.attach_file "profile[image]", Rails.root + 'spec/factories/images/image_1.jpg'

			check 'Publish'
			click_on 'Create profile'

			expect(page).to have_content("Profile created")

			expect(Profile.last.title).to eq('Lucas Films inc.')
			expect(Profile.last.type).to eq('CompanyProfile')
		end

	end
end