# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  confirmed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :registration do
    user_id 1
event_id 1
confirmed false
  end

end
