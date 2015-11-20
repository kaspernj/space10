# == Schema Information
#
# Table name: project_partnerships
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  partner_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  person_id     :integer
#  type          :string
#

require 'rails_helper'

RSpec.describe ProjectPartnership, type: :model do
  describe 'validations' do
    it { should validate_presence_of :resource_type }
  end
end
