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
#  slug                  :string
#  rateable              :boolean
#

FactoryGirl.define do
  factory :post do
    title "MyString"
    publish_at 2.days.ago.to_s(:formatted)
    published true
    rateable false
    content "Primary content"
    excerpt "Excerpt"
    lab
    transient do
      images_count 3
    end
    after :create do |post, evaluator|
      create_list(:image_attachment, evaluator.images_count, resource: post)
    end
  end
end
