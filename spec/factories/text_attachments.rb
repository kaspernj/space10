# == Schema Information
#
# Table name: text_attachments
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  content       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :text_attachment do
    resource_type "MyString"
resource_id 1
content "MyText"
  end

end
