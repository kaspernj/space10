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
#

class ProjectPartnership < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :project_partner, foreign_key: 'partner_id', class_name: 'CompanyProfile'

  validates_presence_of :resource_id, :resource_type, :partner_id
end
