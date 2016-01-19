# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#

FactoryGirl.define do
  factory :profile_tag do
    title "MyString"
    type "ProfileTag"
  end

end
