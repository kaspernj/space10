json.profiles_count @profiles.count
json.profiles do
  json.array! @profiles, partial: 'profile', as: :profile
end