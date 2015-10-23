# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  location    :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  published   :boolean
#

FactoryGirl.define do
  factory :profile do
    title "MyString"
description "MyText"
location "MyString"
type ""
  end

end
