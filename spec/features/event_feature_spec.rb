require 'rails_helper'

RSpec.describe 'events feature', type: :feature do
	describe "event creation" do
		let!(:user) 		{ create(:user, admin: true) }
		let!(:partner) { create(:profile, type: "CompanyProfile") }
		let!(:person) 	{ create(:profile, type: "PersonalProfile") }

		before :each do
			sign_in(user)

			visit new_admin_event_path
			expect(current_path).to eq new_admin_event_path

			fill_in 'Title', with: 'Awesome event'
			fill_in 'Starts at', with: DateTime.now.to_s(:formatted)
		end

		it 'allows admins to create an event' do
			
			fill_in 'Excerpt', with: 'Nothing but awesome'
			fill_in 'Primary content', with: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore, accusantium quia cum enim, vel quisquam eos voluptatum. Fugiat, temporibus tempora sint doloremque a distinctio quidem blanditiis quae ratione. Qui, distinctio.'

			fill_in 'Venue name', with: 'Space 10'
			fill_in 'Address line 1', with: 'Koedbyen 10'
			fill_in 'Zip code', with: '1410'
			fill_in 'City', with: 'Copenhagen'
			fill_in 'Country', with: 'Denmark'

			click_on "Publish now"

			expect(page).to have_content('Event created successfully')
			expect(Event.last.publish_at).to_not eq nil
		end

		it "allows scheduling in the future", js: true do
			
			check 'Schedule'
			fill_in 'event_publish_at', with: DateTime.tomorrow.to_s(:formatted)

			click_on 'Schedule'

			expect(page).to have_content('Event created successfully')
			expect(Event.published.count).to eq 0
			expect(Event.scheduled.count).to eq 1
		end

		it 'allows featured image attachements'
		
		context 'adding content blocks' do

			it 'allows to associate project partners', js: true do
				click_on "Add project partner"
				expect(page).to have_content "Project partner"
				select partner.title, from: 'Project partner'
				click_on 'Publish now'
				expect(page).to have_content 'Event created successfully'
				expect(Event.last.project_partners.pluck(:title)).to include partner.title
			end

			it 'allows to associate project people', js: true do
				click_on "Add project person"
				expect(page).to have_content "Project person"
				select person.title, from: 'Project person'
				click_on 'Publish now'
				expect(page).to have_content 'Event created successfully'
				expect(Event.last.project_people.pluck(:title)).to include person.title
			end

			it 'allows admins to add text blocks to events', js: true do
				click_on "Add text block"
				expect(page).to have_content "Text block content"
				all('div[contenteditable]').last.set('Dummy text')
				click_on 'Publish now'
				expect(page).to have_content 'Event created successfully'
				expect(Event.last.text_blocks.last.text_attachment.content).to eq "Dummy text"
			end

			it 'allows admins to add image blocks to events', js: true do
				click_on "Add image block"
				page.should have_xpath "//input[contains(@name,'[image_attachment_attributes][image]')]"
				find(:xpath, "//input[contains(@name,'[image_attachment_attributes][image]')]").set(Rails.root + 'spec/factories/images/image_1.jpg')
				click_on 'Publish now'
				expect(page).to have_content 'Event created successfully'
				expect(Event.last.image_blocks.last.image_attachment.image).not_to eq nil
			end

			it 'allows admins to add image slider blocks to events', js: true do
				click_on "Add image slider block"
				expect(page).to have_css('.image_slider_block')
				within('.image_slider_block') do
					click_on 'Add image'
					page.should have_xpath "//input[contains(@name,'event[image_slider_blocks_attributes]')]"
					find(:css, '.upload_image').set(Rails.root + 'spec/factories/images/image_1.jpg')
				end
				click_on 'Publish now'
				expect(page).to have_content 'Event created successfully'
				expect(Event.last.image_slider_blocks.last.image_attachments.last.image).not_to eq nil
			end

			it 'allows admins to add video blocks to events', js: true do
				click_on "Add video block"
				expect(page).to have_content "Video url"
			end
		end
	end
end