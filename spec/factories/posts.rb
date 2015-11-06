# == Schema Information
#
# Table name: posts
#
#  id                    :integer          not null, primary key
#  title                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  excerpt               :text
#  content               :text
#  publish_at            :datetime
#  published             :boolean
#  lab_id                :integer
#  project_partners_text :text
#  project_people_text   :text
#

FactoryGirl.define do
  factory :post do
    title "MyString"
    publish_at 2.days.ago.to_s(:formatted)
    published true
  end

end
