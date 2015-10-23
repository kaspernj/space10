# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  resource_type :string
#  resource_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :tagging do
    tag_id 1
resource_type "MyString"
resource_id 1
  end

end
