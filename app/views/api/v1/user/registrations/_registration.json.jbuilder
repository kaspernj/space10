json.id registration.id
json.confirmation_status registration.confirmation_status
json.event do
	json.partial! 'api/v1/events/event', event: registration.event
end