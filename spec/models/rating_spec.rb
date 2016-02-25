# == Schema Information
#
# Table name: ratings
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  resource_type :string
#  resource_id   :integer
#  content       :text
#  score         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of(:user_id).scoped_to([:resource_id, :resource_type]) }
  end
end
