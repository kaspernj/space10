json.id profile.id
json.type profile.type
json.title profile.title
json.tagline profile.tagline
json.email profile.email
json.website profile.website
json.description profile.description
json.location profile.location
json.tags profile.tags, :id, :title
json.image do
  json.small profile.image_url(:thumbnail)
  json.medium profile.image_url(:medium)
  json.large profile.image_url(:large)
end
json.logo profile.type == 'CompanyProfile' ? (profile.logo.present? ? profile.logo_url(:medium) : nil) : nil