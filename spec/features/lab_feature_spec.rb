require 'rails_helper'

RSpec.describe 'Lab feature', type: :feature do
	describe 'lab creation' do
		before :each do
			user = create(:user, admin: true)
			sign_in user
			visit new_admin_lab_path
		end
		it 'should allow admins to create a lab' do
			fill_in 'Title', with: 'Future Living Lab'
			check 'Publish'
			click_on 'Create lab'

			expect(Lab.last.title).to eq('Future Living Lab')
		end
	end
end