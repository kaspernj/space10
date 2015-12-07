require 'rails_helper'

RSpec.describe 'Post feature', type: :feature do
	describe 'post creation' do
		context 'when logged in as admin' do

			let!(:user) 		{ create(:user, admin: true) }
			let!(:partner) { create(:profile, type: "CompanyProfile") }
			let!(:person) 	{ create(:profile, type: "PersonalProfile") }
			
			before :each do
				sign_in user
				visit new_admin_post_path
				fill_in 'Title', with: 'My title'
				fill_in 'Excerpt', with: 'My exerpt'
			end
			
			it 'allows admins to create posts' do
				click_on 'Publish now'
				expect(Post.last.title).to eq 'My title'
			end

			it "allows scheduling in the future", js: true do
				check 'Schedule'
				fill_in 'post_publish_at', with: DateTime.tomorrow.to_s(:formatted)

				click_on 'Schedule'

				# expect(page).to have_content('Post created successfully')
				expect(current_path).to eq admin_posts_path
				expect(Post.published.count).to eq 0
				expect(Post.scheduled.count).to eq 1
			end

			it 'allows featured image attachements'

			context 'adding content blocks' do

				it 'allows to associate project partners', js: true do
					click_on "Add project partner"
					expect(page).to have_content "Project partner"
					select partner.title, from: 'Project partner'
					click_on 'Publish now'
					expect(current_path).to eq admin_posts_path
					expect(Post.last.project_partners.pluck(:title)).to include partner.title
				end

				it 'allows to associate project people', js: true do
					click_on "Add project person"
					expect(page).to have_content "Project person"
					select person.title, from: 'Project person'
					click_on 'Publish now'
					expect(current_path).to eq admin_posts_path
					expect(Post.last.project_people.pluck(:title)).to include person.title
				end

				it 'allows admins to add text blocks to posts', js: true do
					click_on "Add text block"
					expect(page).to have_content "Text block content"
					all('div[contenteditable]').last.set('Dummy text')
					click_on 'Publish now'
					expect(current_path).to eq admin_posts_path
					expect(Post.last.text_blocks.last.text_attachment.content).to eq "Dummy text"
				end

				it 'allows admins to add image blocks to posts', js: true do
					click_on "Add image block"
					page.should have_xpath "//input[contains(@name,'[image_attachment_attributes][image]')]"
					find(:xpath, "//input[contains(@name,'[image_attachment_attributes][image]')]").set(Rails.root + 'spec/factories/images/image_1.jpg')
					click_on 'Publish now'
					expect(current_path).to eq admin_posts_path
					expect(Post.last.image_blocks.last.image_attachment.image).not_to eq nil
				end

				it 'allows admins to add image slider blocks to posts', js: true do
					click_on "Add image slider block"
					expect(page).to have_css('.image_slider_block')
					within('.image_slider_block') do
						click_on 'Add image'
						page.should have_xpath "//input[contains(@name,'post[image_slider_blocks_attributes]')]"
						find(:css, '.upload_image').set(Rails.root + 'spec/factories/images/image_1.jpg')
					end
					click_on 'Publish now'
					expect(current_path).to eq admin_posts_path
					expect(Post.last.image_slider_blocks.last.image_attachments.last.image).not_to eq nil
				end

				it 'allows admins to add video blocks to posts', js: true do
					click_on "Add video block"
					expect(page).to have_content "Video url"
				end
			end		
		end
	end
end