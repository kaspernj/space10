json.content do
  json.small block.image_attachment.image_url(:small)
  json.medium block.image_attachment.image_url(:medium)
  json.large block.image_attachment.image_url(:large)
end