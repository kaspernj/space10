# == Schema Information
#
# Table name: profile_authorizations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  profile_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :profile_authorization do
    user_id 1
profile_id 1
  end

end
