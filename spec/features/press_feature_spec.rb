require 'rails_helper'

RSpec.describe 'Press mention feature', type: :feature do
  describe 'press mention creation' do
    context 'when logged in as admin' do
      let!(:admin) { create(:user, admin: true) }
      let!(:mention) { create(:press_mention) }

      before :each do
        sign_in admin
      end

      it 'allows to create press mention' do
        visit new_admin_press_mention_path
        fill_in 'Title', with: 'Headline'
        fill_in 'Excerpt', with: 'Excerpt'
        fill_in 'Source', with: 'Source'
        fill_in 'Url', with: 'Url'
        fill_in 'Published at', with: 2.days.ago.to_s(:formatted)
        page.attach_file 'Image', Rails.root + 'spec/factories/images/image_1.jpg'

        expect { click_on 'Create Press mention' }.to change(PressMention, :count).by 1
      end

      it 'allows to edit a mention' do
        visit edit_admin_press_mention_path(mention)
        fill_in "Title", with: "New Title"
        click_on "Update"
        expect(mention.reload.title).to eq "New Title"
      end

      it 'allows to destroy a mention'
      
    end
  end
end