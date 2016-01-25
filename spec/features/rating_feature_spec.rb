require 'rails_helper'

RSpec.describe 'Rating feature', type: :feature do
  let!(:admin) { create :user, admin: true }
  let!(:user) { create :user }
  let!(:post) { create :post }
  let!(:rateable_post) { create :post, rateable: true }

  describe 'toggling rating' do
    before :each do
      sign_in(admin)
    end

    it 'allows to toggle rating' do
      visit edit_admin_post_path(post)
      check "post[rateable]"
      click_on 'Save'
      visit post_path(post)
      expect(page).to have_content "Rate this project"
    end
  end

  describe 'rating' do

    context 'not signed in' do
      it 'should prompt sign up', js: true do
        visit post_path(rateable_post)
        page.find(:xpath, '//input[@value="5"]').trigger('click')
        expect(page).to have_content 'Sign up'
      end
    end

    context 'signed in' do
      it 'should be possible to leave a rating', js: true do
        sign_in user
        visit post_path(rateable_post)
        page.find(:xpath, '//input[@value="5"]').click
        expect(page).to have_content 'Update'
      end
    end
  end
end