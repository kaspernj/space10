require "rails_helper"

RSpec.describe "PasswordResets", type: :feature do
  let!(:user) { create(:user) }

  describe "resetting password" do
    it "emails user when requesting password reset" do
      visit login_path
      click_on "password"
      fill_in "Email", with: user.email
      click_on "Reset password"
      expect(page).to have_content "Email sent with reset instructions"
      expect(last_email.to).to include(user.email)
    end

    it "does not email invalid user when requesting password reset" do
      visit login_path
      click_on "password"
      fill_in "Email", with: "nobody@email.com"
      click_on "Reset password"
      expect(page).to have_content "Email sent with reset instructions"
      expect(last_email.subject).not_to eq "Password reset instructions"
    end

    it "updates the user password when confirmation matches" do
      user.update_attributes(password_reset_token: "something", password_reset_sent_at: 1.hour.ago)
      visit edit_password_reset_path(user.password_reset_token)
      fill_in "Password", with: "foobar123"
      click_on "Update password"
      expect(page).not_to have_content "Your password has been reset!"

      fill_in "Password", with: "foobar123"
      fill_in "Password confirmation", with: "foobar123"
      click_on "Update password"
      expect(page).to have_content "Your password has been reset!"
    end

    it "reports when password has expired" do
      user.update_attributes(password_reset_token: "something", password_reset_sent_at: 5.hour.ago)
      visit edit_password_reset_path(user.password_reset_token)

      fill_in "Password", with: "foobar123"
      fill_in "Password confirmation", with: "foobar123"
      click_on "Update password"
      expect(page).to have_content "Password reset link has expired. Please request a new one."
    end

    it "raises record not found when password_reset_token is invalid" do
      expect { visit edit_password_reset_path("wrong") }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
