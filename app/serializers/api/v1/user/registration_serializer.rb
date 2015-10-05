class Api::V1::User::RegistrationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_id, :confirmed, :created_at, :updated_at
  has_one :event
end
