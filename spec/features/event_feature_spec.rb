require 'rails_helper'

RSpec.describe 'events feature', type: :feature do
	describe "event creation" do
		before :each do
			user = create(:user, admin: true)
			sign_in(user)

			visit new_admin_event_path
			expect(current_path).to eq new_admin_event_path

			fill_in 'Title', with: 'Awesome event'
			fill_in 'Starts at', with: DateTime.now.strftime('%m/%d/%Y %H:%M')
		end

		it 'allows admins to create an event' do
			
			fill_in 'Excerpt', with: 'Nothing but awesome'
			fill_in 'Content', with: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore, accusantium quia cum enim, vel quisquam eos voluptatum. Fugiat, temporibus tempora sint doloremque a distinctio quidem blanditiis quae ratione. Qui, distinctio.'

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
			fill_in 'event_publish_at', with: DateTime.tomorrow.strftime('%m/%d/%Y %H:%M')

			click_on 'Schedule'

			expect(page).to have_content('Event created successfully')
			expect(Event.published.count).to eq 0
			expect(Event.scheduled.count).to eq 1
		end

		it 'allows image attachements'
		# it 'allows image attachement', js: true, focus: true do
		# 	click_on 'Add image'

		# 	script = "$('.file_upload').removeClass('file_upload');"
  #   	page.execute_script(script)

  #   	expect(page).to have_css('.upload_image')
			
		# 	attach_file('.upload_image', Rails.root + 'spec/factories/images/image_1.jpg')
		# 	click_on "Publish now"

		# 	expect(Event.last.image_attachments.count).to eq 1
		# 	expect(ImageAttachment.last.image).not_to eq nil
		# end
	end
end