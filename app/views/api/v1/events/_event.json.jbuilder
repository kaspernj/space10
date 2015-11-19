json.id event.id
json.title event.title
json.excerpt event.excerpt
json.content event.content
json.featured_image event.featured_image.present? ? event.featured_image_url : nil
json.secondary_image event.secondary_image.present? ? event.secondary_image_url : nil
json.starts_at event.starts_at.iso8601
json.ends_at event.ends_at.iso8601
json.published_at event.published_at.iso8601