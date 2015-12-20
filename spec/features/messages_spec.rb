require 'rails_helper'

describe 'messaging', type: :feature do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }

  before :each do
    user_2.personal_profile.update_attributes(published: true, email: user_2.email)
  end

  context 'signed in' do
    before :each do
      sign_in user_1
    end

    it 'allows to message community users', js: true do
      visit profile_path(user_2.personal_profile)

      expect(page).to have_content "Get in touch".upcase
      click_on "Get in touch"

      expect(page).to have_content "To: #{user_2.personal_profile.title}".upcase
      fill_in "message[body]", with: "Hola chica"
      click_on "Send message"

      expect(page).to have_content "Your message was sent!"

      expect(last_email.to).to include user_2.email
      expect(last_email.body).to include "Hola chica"
    end
  end

  context 'not signed in' do
    it 'does not allow messaging', js: true do
      visit profile_path(user_2.personal_profile)

      expect(page).to have_content "GET IN TOUCH"
      click_on "Get in touch"

      expect(page).not_to have_content "To #{user_2.personal_profile.title}"
    end
  end
end