json.id lab.id
json.title lab.title
json.subtitle lab.subtitle
json.events lab.events, partial: 'api/v1/events/event', as: :event
json.posts lab.posts, partial: 'api/v1/posts/post', as: :post