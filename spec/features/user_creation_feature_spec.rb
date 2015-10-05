require 'rails_helper'

describe 'user creation', type: :feature do
	it 'allowers visitors to create a user' do
		visit new_user_path

		fill_in 'First name', with: 'John'
		fill_in 'Last name', with: 'Doe'
		fill_in 'Email', with: 'John@email.com'
		fill_in 'Password', with: 'foobar12'
		fill_in 'Password confirmation', with: 'foobar12'

		click_on "Create user"

		expect(page).to have_content('Signed up successfully')
		expect(page).to have_content('Log out')
	end

	it 'allows visitors to sign up with facebook' do
		omniauth_facebook_hash
		visit new_user_path
		click_on 'Sign up with Facebook'
		
		expect(page).to have_content('Logged in successfully')
		expect(page).to have_content('Log out')
	end

	it 'handles authentication failure' do
		OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
		visit new_user_path
		click_on 'Sign up with Facebook'

		expect(page).to have_content('Authentication failed')
	end

	describe 'when signed in' do
		before :each do
			user = create(:user)
			sign_in user
		end

		it 'do not allow to create new user' do
			visit new_user_path
			expect(current_path).to eq root_path
		end
	end

end