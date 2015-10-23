# == Schema Information
#
# Table name: labs
#
#  id         :integer          not null, primary key
#  title      :string
#  subtitle   :string
#  published  :boolean
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :lab do
    title "MyString"
subtitle "MyString"
published false
starts_at "2015-10-16 13:40:45"
ends_at "2015-10-16 13:40:45"
  end

end
