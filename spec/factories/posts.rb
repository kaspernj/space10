# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  excerpt    :text
#  content    :text
#  publish_at :datetime
#  published  :boolean
#

FactoryGirl.define do
  factory :post do
    title "MyString"
  end

end
