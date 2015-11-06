# == Schema Information
#
# Table name: project_partnerships
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  partner_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  person_id     :integer
#  type          :string
#

FactoryGirl.define do
  factory :project_partnership do
    resource_type "MyString"
resource_id 1
partner_id ""
  end

end
