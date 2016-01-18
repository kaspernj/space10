json.id post.id
json.title post.title
json.excerpt post.excerpt
json.featured_image do
   json.small post.featured_image_url(:small)
   json.medium post.featured_image_url(:medium)
   json.large post.featured_image_url(:large)
end
json.featured_images post.image_attachments do |image|
   json.small image.image_url(:small)
   json.medium image.image_url(:medium)
   json.large image.image_url(:large)
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
  json.partners post.project_partners do |project_partner|
    json.id project_partner.id
    json.title project_partner.title
    json.images do
      json.small project_partner.logo_url(:small)
      json.medium project_partner.logo_url(:medium)
      json.large project_partner.logo_url
    end
  end
end
json.project_people do
  json.text post.project_people_text
  json.people post.project_people do |project_person|
    json.id project_person.id
    json.title project_person.title
    json.images do
      json.small project_person.image_url(:thumbnail)
      json.medium project_person.image_url(:medium)
      json.large project_person.image_url(:large)
    end
  end
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