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

class CompanyPartnership < ProjectPartnership
  belongs_to :project_partner, foreign_key: 'partner_id', class_name: 'CompanyProfile'

  validates_presence_of :partner_id
end
