require "rails_helper"

describe "Registrations api", type: :request do
	let!(:event) { create :event, title: "Great Talk" }
	let!(:another_event) { create :event, title: "Awesome Keynote" }
	let!(:user) { create :user }
	let!(:registration) { create :registration, user: user, event: event }

	describe "GET /api/user/registrations" do
		it 'should return registrations of authenticated user' do
			get '/api/user/registrations', {}, request_headers(user: user)
			
			expect(response.status).to eq 200 # ok
			expect(response_body).to eq(
				[{
					'id' => registration.id,
					'confirmation_status' => 'unconfirmed',
					'event' => {
							'id' => event.id,
							'title' => event.title,
							'excerpt' => event.excerpt,
							'content' => event.content,
							'starts_at' => event.starts_at.in_time_zone('Copenhagen').iso8601,
							'ends_at' => event.ends_at.in_time_zone('Copenhagen').iso8601,
							'published_at' => event.published_at.in_time_zone('Copenhagen').iso8601
						},
				}]
			)
		end
	end

	describe 'GET /api/user/registration/:id' do
		it 'should return requested registration' do
			get "/api/user/registrations/#{registration.id}", {}, request_headers(user: user)
			
			expect(response.status).to eq 200 # ok
			expect(response_body).to eq(
				{
					'id' => registration.id,
					'confirmation_status' => 'unconfirmed',
					'event' => {
							'id' => event.id,
							'title' => event.title,
							'excerpt' => event.excerpt,
							'content' => event.content,
							'starts_at' => event.starts_at.in_time_zone('Copenhagen').iso8601,
							'ends_at' => event.ends_at.in_time_zone('Copenhagen').iso8601,
							'published_at' => event.published_at.in_time_zone('Copenhagen').iso8601
						},
				}
			)
		end

		it 'should return 404 for requested registration not made by authenticated user' do
			another_user = create(:user)
			another_registration = create(:registration, event: event, user: another_user)

			get "/api/user/registrations/#{another_registration.id}", {}, request_headers(user: user)
			
			expect(response.status).to eq 404 # ok
		end
	end

	describe 'POST /api/user/registrations' do
		it 'should be possible to register for an event' do
			registration_params = {
				"registration" => {
					"user_id" => user.id,
					"event_id" => another_event.id
				}
			}.to_json

			post "/api/user/registrations", registration_params, request_headers(user: user)

			expect(response.status).to eq 200 # created
			expect(response_body).to eq (
				{
					'id' => Registration.last.id,
					'confirmation_status' => 'unconfirmed',
					'event' => {
							'id' => another_event.id,
							'title' => another_event.title,
							'excerpt' => another_event.excerpt,
							'content' => another_event.content,
							'starts_at' => another_event.starts_at.in_time_zone('Copenhagen').iso8601,
							'ends_at' => another_event.ends_at.in_time_zone('Copenhagen').iso8601,
							'published_at' => another_event.published_at.in_time_zone('Copenhagen').iso8601
						},
				}
			)
		end
	end

	describe 'DELETE /api/user/registrations/:id' do
		it 'should be possible to delete a registration' do
			delete "/api/user/registrations/#{registration.id}", {}, request_headers(user: user)

			expect(response.status).to eq 200
		end
	end

end