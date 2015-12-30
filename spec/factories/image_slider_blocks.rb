# == Schema Information
#
# Table name: content_blocks
#
#  id            :integer          not null, primary key
#  type          :string
#  resource_type :string
#  resource_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  row_order     :integer
#

FactoryGirl.define do
  factory :image_slider_block do
    type "ImageSliderBlock"
    resource_type "MyString"
    resource_id 1
    image_attachments { create_list(:image_attachment, 3) }
  end
end
