json.id event.id
json.title event.title
json.excerpt event.excerpt
json.content event.content
json.content_blocks event.content_blocks do |block|
  json.id block.id
  json.type block.type
  json.row_order block.row_order
  json.partial! "api/v1/content_blocks/#{block.type.underscore}", block: block
end
json.featured_image do
   json.small event.featured_image_url(:small)
   json.medium event.featured_image_url(:medium)
   json.large event.featured_image_url(:large)
end
json.secondary_image do
   json.small event.secondary_image_url(:small)
   json.medium event.secondary_image_url(:medium)
   json.large event.secondary_image_url(:large)
end
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