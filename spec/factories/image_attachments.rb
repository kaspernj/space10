# == Schema Information
#
# Table name: image_attachments
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  title         :string
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image         :string
#  row_order     :integer
#

FactoryGirl.define do
  factory :image_attachment do
    resource_type "MyString"
		resource_id 1
		title "MyString"
		description "MyString"
		image { File.new("#{Rails.root}/spec/factories/images/image_1.jpg") } 
  end

end
