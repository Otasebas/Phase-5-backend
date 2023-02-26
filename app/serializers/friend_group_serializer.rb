class FriendGroupSerializer < ActiveModel::Serializer
  attributes :id, :group_name, :username
  # has_one :user
  def username
    object.user.username
  end
end
