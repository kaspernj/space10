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
        find("[for=rating_score_5]").click
        expect(current_path).to eq post_path(rateable_post)
        wait_for_ajax
        expect(page).to have_selector('.modal', visible: true)
        within '.modal' do
          expect(page).to have_link 'Join with'
        end
      end
    end
    context "signed in" do
      it "should allow rating", js: true do
        sign_in user
        visit post_path(rateable_post)
        expect(Rating.all.count).to eq 0
        find("[for=rating_score_5]").click
        wait_for_ajax
        expect(Rating.all.count).to eq 1
        expect(page).to have_selector('.modal', visible: true)
        within '.modal' do
          expect(page).to have_link 'Join with'
        end
      end
    end
  end
end