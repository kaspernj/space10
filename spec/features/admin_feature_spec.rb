require 'rails_helper'

describe 'admin', type: :feature do
	it 'should only allow admins in the admin area' do
		user = create(:user)
		sign_in(user)
		visit admin_root_path
		expect(current_path).to eq(root_path)

		user.update!(admin: true)

		visit admin_root_path
		expect(current_path).to eq(admin_root_path)
	end
end