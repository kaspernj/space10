json.partial! 'user', user: @user

json.personal_profile @user.personal_profile, partial: 'api/v1/profiles/profile', as: :profile
json.company_profiles @user.company_profiles, partial: 'api/v1/profiles/profile', as: :profile