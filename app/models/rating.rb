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
  validates :user_id, uniqueness: { scope: [:resource_id, :resource_type] }

  belongs_to :resource, polymorphic: true
end
