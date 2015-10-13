require 'rails_helper'

RSpec.describe 'Post feature', type: :feature do
	describe 'post creation' do
		context 'when logged in as admin' do
			before :each do
				user = create(:user, admin: true)
				sign_in user
				visit new_admin_post_path
			end
			
			it 'allows admins to create posts' do
				fill_in 'Title', with: 'My title'
				fill_in 'Excerpt', with: 'My exerpt'
				
				click_on 'Publish now'
				expect(Post.last.title).to eq 'My title'
			end

			it 'allows admins to add text blocks to posts'
			it 'allows admins to add image blocks to posts'
			it 'allows admins to add video blocks to posts'
		end
	end
end