# == Schema Information
#
# Table name: press_mentions
#
#  id           :integer          not null, primary key
#  title        :string
#  excerpt      :text
#  url          :string
#  source       :string
#  published_at :datetime
#  image        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  published    :boolean
#  featured     :boolean
#

FactoryGirl.define do
  factory :press_mention do
    title "MyString"
excerpt "MyText"
url "MyString"
source "MyString"
published_at "2015-12-15 08:19:07"
image "MyString"
  end

end
