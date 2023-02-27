class FriendGroupSerializer < ActiveModel::Serializer
  attributes :id, :group_name, :creator, :members
  # has_one :user
  def creator
    object.user.username
  end

  def members
    memberships = object.members.all.where(joined: true)
    users = memberships.map do |membership|
      { id: membership.user.id, 
        username: membership.user.username, 
        nickname: membership.user.nickname,
        member_id: membership.id
      }
    end
  end
end
