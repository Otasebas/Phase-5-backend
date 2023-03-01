class EventUserSerializer < ActiveModel::Serializer
  attributes :id, :creator, :attendance, :invite_sent
  has_one :user
  has_one :calendar_date
  has_one :group
end
