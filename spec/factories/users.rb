# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  password_digest        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auth_token             :string
#  admin                  :boolean          default(FALSE)
#  name                   :string
#  birthday               :date
#  gender                 :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#

FactoryGirl.define do
  factory :user do
    name "John Doe"
		sequence(:email) { |n| "email_#{n}@example.com" }
		password "abc123456"
  end

end
