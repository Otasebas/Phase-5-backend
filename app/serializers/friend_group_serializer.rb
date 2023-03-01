class FriendGroupSerializer < ActiveModel::Serializer
  attributes :id, :group_name, :creator, :members, :group_calendar
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
        member_id: membership.id,
        friend_group_id: object.id,
        phone_number: membership.user.phone_number
      }
    end
  end

  def group_calendar
    object.calendar_dates.uniq
  end
end
