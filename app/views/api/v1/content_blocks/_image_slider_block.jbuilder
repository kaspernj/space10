json.content block.image_attachments do |attachment|
  json.small attachment.image_url(:small)
  json.medium attachment.image_url(:medium)
  json.large attachment.image_url(:large)
end