json.id post.id
json.title post.title
json.excerpt post.excerpt
json.featured_image post.featured_image.present? ? post.featured_image_url : nil
json.tags post.tags, :id, :title
json.content post.content
json.published_at post.published_at.iso8601
json.project_partners do
  json.text post.project_partners_text
  json.partners post.project_partners, :id, :title, :logo_url
end
json.project_people do
  json.text post.project_people_text
  json.people post.project_people, :id, :title, :image_url
end
json.lab do
  if post.lab.present?
    json.id post.lab.id
    json.title post.lab.title
    json.subtitle post.lab.subtitle
  else
    json.nil!
  end
end