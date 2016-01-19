require 'rails_helper'

RSpec.describe 'Tag feature', type: :feature do
  describe 'tag creation' do
    context 'when logged in as admin' do
      let!(:admin) { create(:user, admin: true) }
      let!(:tag) { create(:post_tag) }

      before :each do
        sign_in admin
      end

      it 'allows to create tag' do
        visit new_admin_tag_path
        fill_in 'Title', with: 'Tag'
        select 'Post', from: 'Type'
        expect { click_on 'Create Tag' }.to change(PostTag, :count).by 1
      end

      it 'allows to edit a tag' do
        visit edit_admin_tag_path(tag)
        fill_in "Title", with: "New tag title"
        click_on "Update"
        expect(tag.reload.title).to eq "New tag title"
      end

      it 'allows to destroy a mention'
      
    end
  end
end