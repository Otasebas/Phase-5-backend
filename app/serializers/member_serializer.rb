class MemberSerializer < ActiveModel::Serializer
  attributes :id, :joined, :username
  # has_one :user
  has_one :friend_group

  def username
    object.user.username
  end
end
