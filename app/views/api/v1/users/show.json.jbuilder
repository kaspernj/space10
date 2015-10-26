json.partial! 'user', user: @user

json.personal_profile @user.personal_profile, partial: 'profiles/profile', as: :profile
json.company_profiles @user.company_profiles, partial: 'profiles/profile', as: :profile