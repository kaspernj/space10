json.content do
  json.title block.image_attachment.title
  json.description block.image_attachment.description
  json.image do
    json.small block.image_attachment.image_url(:small)
    json.medium block.image_attachment.image_url(:medium)
    json.large block.image_attachment.image_url(:large)
  end
end