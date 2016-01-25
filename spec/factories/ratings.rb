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

FactoryGirl.define do
  factory :rating do
    user_id 1
    resource_type "MyString"
    resource_id 1
    content "MyText"
    score 1
  end

end
