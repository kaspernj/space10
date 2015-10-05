# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  name       :string
#  address_1  :string
#  address_2  :string
#  zipcode    :string
#  city       :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :address do
    name "MyString"
address_1 "MyString"
address_2 "MyString"
zipcode "MyString"
city "MyString"
country "MyString"
  end

end
