require 'rails_helper'

describe 'user authentication', type: :feature do
	it "allows signin with valid credentials" do
		user = create(:user)
		sign_in(user)

		expect(page).to have_content("Logged in successfully")
	end

	it "does not allow signin with invalid credentials" do
		user = create(:user)
		sign_in(user, password: "incorrect")

		expect(page).to have_content("Invalid email or password")
	end

	it "allows user to sign out" do
		user = create(:user)
		sign_in(user)

		visit root_path
		page.find("#logout").click

		expect(page).to have_content("Logged out successfully")
	end

	it 'do not allow to sign in after signed in' do
		user = create(:user)
		sign_in user
		visit login_path
		expect(current_path).to eq root_path
	end

end