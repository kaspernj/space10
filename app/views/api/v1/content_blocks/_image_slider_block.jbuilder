json.content do
  json.title block.title
  json.description block.description
  json.images block.image_attachments do |attachment|
    json.small attachment.image_url(:small)
    json.medium attachment.image_url(:medium)
    json.large attachment.image_url(:large)
  end
end