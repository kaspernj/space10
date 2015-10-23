# == Schema Information
#
# Table name: video_attachments
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :string
#  featured      :boolean
#  provider      :string
#  video_id      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  video_url     :string
#  resource_type :string
#  resource_id   :integer
#  image         :string
#

FactoryGirl.define do
  factory :video_attachment do
    title "MyString"
description "MyString"
featured false
provider "MyString"
video_id "MyString"
  end

end
