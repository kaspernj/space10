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
  factory :text_block do
    type "TextBlock"
    resource_type "MyString"
    resource_id 1
    text_attachment
  end
end
