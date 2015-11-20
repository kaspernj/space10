require 'rails_helper'

RSpec.describe 'Post feature', type: :feature do
	describe 'post creation' do
		context 'when logged in as admin' do
			before :each do
				user = create(:user, admin: true)
				@partner = create(:profile, type: "CompanyProfile")
				@person = create(:profile, type: "PersonalProfile")
				sign_in user
				visit new_admin_post_path
				fill_in 'Title', with: 'My title'
				fill_in 'Excerpt', with: 'My exerpt'
			end
			
			it 'allows admins to create posts' do
				click_on 'Publish now'
				expect(Post.last.title).to eq 'My title'
			end

			it 'allows to associate project partners', js: true, focus: true do
				click_on "Add project partner"
				expect(page).to have_content "Project partner"
				select @partner.title, from: 'Project partner'
				click_on 'Publish now'
				expect(current_path).to eq admin_posts_path
				expect(Post.last.project_partners.pluck(:title)).to include @partner.title
			end

			it 'allows to associate project people', js: true, focus: true do
				click_on "Add project person"
				expect(page).to have_content "Project person"
				select @person.title, from: 'Project person'
				click_on 'Publish now'
				expect(current_path).to eq admin_posts_path
				expect(Post.last.project_people.pluck(:title)).to include @person.title
			end

			it 'allows admins to add text blocks to posts'
			it 'allows admins to add image blocks to posts'
			it 'allows admins to add video blocks to posts'

			it "allows scheduling in the future", js: true do
				check 'Schedule'
				fill_in 'post_publish_at', with: DateTime.tomorrow.to_s(:formatted)

				click_on 'Schedule'

				expect(page).to have_content('Post created successfully')
				expect(Post.published.count).to eq 0
				expect(Post.scheduled.count).to eq 1
			end

			it 'allows featured image attachements'

			
		end
	end
end