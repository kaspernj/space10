# == Schema Information
#
# Table name: logo_attachments
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  image         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :logo_attachment do
    resource_type "MyString"
resource_id 1
image "MyString"
  end

end
