# == Schema Information
#
# Table name: project_partnerships
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  partner_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  person_id     :integer
#  type          :string
#

class PersonPartnership < ProjectPartnership
  belongs_to :project_person, foreign_key: 'person_id', class_name: 'PersonalProfile'

  validates_presence_of :person_id
end
