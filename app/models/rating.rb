# == Schema Information
#
# Table name: ratings
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  resource_type :string
#  resource_id   :integer
#  content       :text
#  score         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Rating < ActiveRecord::Base
  validates :score, presence: true, inclusion: 1..5

  belongs_to :resource, polymorphic: true
end
