require 'rails_helper'

RSpec.describe 'Press mention feature', type: :feature do
  describe 'press mention creation' do
    context 'when logged in as admin' do
      let!(:admin) { create(:user, admin: true) }

      before :each do
        sign_in admin
      end

      it 'allows to create press mention' do
        visit new_admin_press_mention_path
      end
    end
  end
end