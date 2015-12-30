json.content do
  json.title block.video_attachment.title
  json.description block.video_attachment.description
  json.video_url block.video_attachment.video_url
  json.provider block.video_attachment.provider
  json.video_id block.video_attachment.video_id
  json.image block.video_attachment.image
end