json.id profile.id
json.type profile.type
json.title profile.title
json.description profile.description
json.location profile.location
json.tags profile.tags, :id, :title
json.avatar profile.image_url(:medium)
json.logo profile.type == 'CompanyProfile' ? (profile.logo.present? ? profile.logo_url(:medium) : nil) : nil