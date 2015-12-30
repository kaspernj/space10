json.id post.id
json.title post.title
json.excerpt post.excerpt
json.featured_image do
   json.small post.featured_image_url(:small)
   json.medium post.featured_image_url(:medium)
   json.large post.featured_image_url(:large)
end
json.tags post.tags, :id, :title
json.content post.content
json.content_blocks post.content_blocks do |block|
  json.id block.id
  json.type block.type
  json.row_order block.row_order
  json.partial! "api/v1/content_blocks/#{block.type.underscore}", block: block
end
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