# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#

class PostTag < Tag
  def self.tokens(query)
    tags = where("lower(title) like ?", "%#{query.downcase}%")
    exact_match = where("lower(title) like ?", "#{query.downcase}")
    if tags.empty?
      [{id: "<<<#{query}>>>", title: "New: \"#{query}\""}]
    elsif exact_match.present?
      tags
    else
      tags
      tags + [{id: "<<<#{query}>>>", title: "New: \"#{query}\""}]
    end
  end
end
