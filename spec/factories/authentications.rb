# == Schema Information
#
# Table name: authentications
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  provider         :string
#  uid              :string
#  oauth_token      :string
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :authentication do
    user_id 1
provider "MyString"
uid "MyString"
oauth_token "MyString"
oauth_expires_at "2015-09-27 17:32:04"
  end

end
