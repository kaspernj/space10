require 'rails_helper'

RSpec.describe 'attend_event_feature', type: :feature do


	describe 'requesting a seat' do

		let!(:user) { create(:user) }
		let!(:admin) { create(:user, admin: true) }
		let!(:event) { create(:event) }

		context 'not signed in' do
			it 'should not be possible to request a seat' do
				visit new_event_registration_path(event)
				expect(current_path).to eq new_user_path
			end
		end

		describe 'when signed in' do
			before :each do
				sign_in user
			end

			it 'should be possible to request a seat', js: true do
				visit event_path(event)
				click_on 'Attend'
				within('.modal-body') do
					click_on 'Yes'
				end
				expect(current_path).to eq event_path(event)
				expect(page).to have_content('SEAT REQUESTED')
				expect(Registration.last.confirmed?).to eq false
				expect(last_email.to).to include user.email
			end

			it 'should not be possible to request a seat on past event' do
				event.update(starts_at: 3.days.ago.to_s(:formatted), ends_at: 2.days.ago.to_s(:formatted))
				expect(event.historic?).to eq true
				visit new_event_registration_path(event)
				expect(current_path).to eq event_path(event)
			end
			
			it 'should not be possible to request multiple seats' do
				visit new_event_registration_path(event)
				expect(page).to have_content('Yes')
				click_on 'Yes'

				visit new_event_registration_path(event)
				expect(page).to have_content "You have already requested a seat for this event"
			end
		end

		describe 'accepting seat requests' do
			it 'should be possible to accept seat requests' do
				registration = create(:registration, user: user, event: event)
				sign_in admin
				visit admin_event_path(event)

				expect(page).to have_content(user.name)
				click_on 'Confirm registration'
				expect(registration.reload.confirmed).to eq true
				expect(last_email.to).to include user.email
			end
		end

	end
end