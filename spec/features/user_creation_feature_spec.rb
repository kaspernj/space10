require 'rails_helper'

describe 'user creation', type: :feature do
	it 'allowers visitors to create a user' do
		visit new_user_path

		fill_in 'Name', with: 'John Doe'
		fill_in 'Email', with: 'John@email.com'
		fill_in 'Password', with: 'foobar12'

		click_on "Create user"

		expect(page).to have_content('Signed up successfully')
		expect(last_email.to).to include 'John@email.com'
		expect(page).to have_content('John')
		expect(User.last.personal_profile.title).to eq User.last.name
	end

	context "with facebook" do
		it 'allows visitors to sign up with facebook' do
			omniauth_facebook_hash
			visit new_user_path
			click_on 'Join with Facebook'
			
			expect(page).to have_content('Logged in successfully')
			expect(page).to have_content('John')
		end

		it 'handles authentication failure' do
			OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
			visit new_user_path
			click_on 'Join with Facebook'

			expect(page).to have_content('Authentication failed')
		end
	end

	context 'with linkedin' do
		it 'allows visitors to sign up with linkedin' do
			omniauth_linkedin_hash
			visit new_user_path
			click_on 'Join with LinkedIn'
			
			expect(page).to have_content('Logged in successfully')
			expect(page).to have_content('John')
		end
	end

	context 'signed in' do
		before :each do
			@user = create(:user)
			sign_in @user
		end

		it 'do not allow to create new user' do
			visit new_user_path
			expect(current_path).to eq root_path
		end

		describe "user update" do
			it 'allows update', js: true do
				click_on 'John'
				expect(page).to have_content @user.name
				
				fill_in 'user[name]', with: "Mouwgli"
				page.attach_file "user[personal_profile_attributes][image]", Rails.root + 'spec/factories/images/image_1.jpg'

				click_on "Save"

				expect(page).to have_content "Mouwgli"
				expect(@user.reload.name).to eq "Mouwgli"
				expect(@user.reload.personal_profile.image).not_to eq nil
			end
		end
	end

end