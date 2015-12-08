json.id user.id
json.auth_token user.auth_token
json.name user.name
json.email user.email
json.birthday user.birthday.try(:strftime,"%F")
json.gender user.gender