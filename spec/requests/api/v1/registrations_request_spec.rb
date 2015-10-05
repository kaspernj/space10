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
			expect(response_body.map{|r| r['event']['id']}).to eq([event.id])
		end
	end

	describe 'GET /api/user/registration/:id' do
		it 'should return requested registration' do
			get "/api/user/registrations/#{registration.id}", {}, request_headers(user: user)
			
			expect(response.status).to eq 200 # ok
			expect(response_body['event']['id']).to eq(event.id)
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

			expect(response.status).to eq 201 # created
			expect(response_body['user_id']).to eq user.id
		end
	end

	describe 'DELETE /api/user/registrations/:id' do
		it 'should be possible to delete a registration' do
			delete "/api/user/registrations/#{registration.id}", {}, request_headers(user: user)

			expect(response.status).to eq 200
		end
	end

end