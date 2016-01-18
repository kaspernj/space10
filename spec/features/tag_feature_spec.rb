require 'rails_helper'

RSpec.describe 'Tag feature', type: :feature do
  describe 'tag creation' do
    context 'when logged in as admin' do
      let!(:admin) { create(:user, admin: true) }
      let!(:tag) { create(:tag) }

      before :each do
        sign_in admin
      end

      it 'allows to create tag' do
        visit new_admin_tag_path
        fill_in 'Title', with: 'Tag'

        expect { click_on 'Create Tag' }.to change(Tag, :count).by 1
      end

      it 'allows to edit a mention' do
        visit edit_admin_tag_path(tag)
        fill_in "Title", with: "New tag title"
        click_on "Update"
        expect(tag.reload.title).to eq "New tag title"
      end

      it 'allows to destroy a mention'
      
    end
  end
end