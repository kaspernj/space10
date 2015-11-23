json.id event.id
json.title event.title
json.excerpt event.excerpt
json.content event.content
json.featured_image event.featured_image.present? ? event.featured_image_url(:large) : nil
json.secondary_image event.secondary_image.present? ? event.secondary_image_url(:large) : nil
json.starts_at event.starts_at.iso8601
json.ends_at event.ends_at.iso8601
json.published_at event.published_at.iso8601
json.project_partners do
  json.text event.project_partners_text
  json.partners event.project_partners, :id, :title, :logo_url
end
json.project_people do
  json.text event.project_people_text
  json.people event.project_people, :id, :title, :image_url
end
json.lab event.lab