json.id user.id
json.auth_token user.auth_token
json.name user.name
json.email user.email
json.birthday user.birthday.try(:strftime,"%F")
json.gender user.gender
json.personal_profile user.personal_profile, partial: 'api/v1/profiles/profile', as: :profile
json.company_profiles user.company_profiles, partial: 'api/v1/profiles/profile', as: :profile