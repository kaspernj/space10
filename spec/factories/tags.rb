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
  factory :tag do
    title "MyString"
    type "PostTag"
  end

end
