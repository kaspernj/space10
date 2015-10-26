json.id registration.id
json.confirmation_status registration.confirmation_status
json.event do
	json.id registration.event.id
	json.title registration.event.title
	json.excerpt registration.event.excerpt
	json.starts_at registration.event.starts_at.to_s(:formatted)
	json.ends_at registration.event.ends_at.to_s(:formatted)
end