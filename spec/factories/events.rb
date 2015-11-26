# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  title                 :string
#  excerpt               :text
#  content               :text
#  starts_at             :datetime
#  ends_at               :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  address_id            :integer
#  publish_at            :datetime
#  published             :boolean
#  max_registrations     :integer
#  slug                  :string
#  lab_id                :integer
#  project_partners_text :text
#  project_people_text   :text
#

FactoryGirl.define do
  factory :event do
    title "MyString"
		excerpt "MyText"
		content "MyText"
		starts_at 2.days.from_now.to_s(:formatted)
		ends_at 3.days.from_now.to_s(:formatted)
		published true
		publish_at 1.day.ago.to_s(:formatted)
  end

end
