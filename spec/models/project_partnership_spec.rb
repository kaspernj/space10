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
#

require 'rails_helper'

RSpec.describe ProjectPartnership, type: :model do
  describe 'validations' do
    it { should validate_presence_of :resource_id }
    it { should validate_presence_of :resource_type }
    it { should validate_presence_of :partner_id }
  end
end
