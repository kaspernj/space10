json.id event.id
json.title event.title
json.excerpt event.excerpt
json.content event.content
json.starts_at event.starts_at.to_s(:formatted)
json.ends_at event.ends_at.to_s(:formatted)
json.published_at event.published_at.to_s(:formatted)