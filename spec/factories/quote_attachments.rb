# == Schema Information
#
# Table name: quote_attachments
#
#  id         :integer          not null, primary key
#  quote      :text
#  author     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :quote_attachment do
    quote "MyText"
author "MyString"
  end

end
