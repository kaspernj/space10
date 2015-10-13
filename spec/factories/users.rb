# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  auth_token      :string
#  admin           :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :user do
    first_name "John"
		last_name "Doe"
		sequence(:email) { |n| "email_#{n}@example.com" }
		password "abc123456"
  end

end
