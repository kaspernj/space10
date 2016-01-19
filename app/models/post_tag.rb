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
