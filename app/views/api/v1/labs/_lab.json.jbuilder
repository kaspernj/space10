json.id lab.id
json.title lab.title
json.subtitle lab.subtitle
json.starts_at lab.starts_at.iso8601
json.ends_at lab.ends_at.iso8601
json.events lab.events, partial: 'api/v1/events/event', as: :event
json.posts lab.posts, partial: 'api/v1/posts/post', as: :post