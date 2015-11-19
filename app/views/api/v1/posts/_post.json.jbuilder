json.id post.id
json.title post.title
json.featured_image post.featured_image.present? ? post.featured_image_url : nil
json.excerpt post.excerpt
json.content post.content
json.published_at post.published_at.iso8601