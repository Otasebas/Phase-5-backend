class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :nickname, :friends, :pending, :request, :group_invites, :groups_member_of

  # has_many :friend_requests_as_requestor
  # has_many :friend_requests_as_receiver

  def friends
    #grab all users as recievers that have a true friend
    receiving_requests = object.friend_requests_as_receiver.where(friends?: true)
    #grab all users as requestors that have a true friend
    requesting_requests = object.friend_requests_as_requestor.where(friends?: true)
  
    #initialize an array
    friends = []
    #go through each part of the recieving users array to find the
    #user object of that reciever
    receiving_requests.each do |request|
      friend_user = User.find_by(id: request.requestor_id)

      #only return specific information of that user
      if friend_user
        friends << {
          id: friend_user.id,
          username: friend_user.username,
          phone_number: friend_user.phone_number,
          nickname: friend_user.nickname,
          request_id: request.id
        }
      end
    end
  
    #again with requestors
    requesting_requests.each do |request|
      friend_user = User.find_by(id: request.receiver_id)
      if friend_user
        friends << {
          id: friend_user.id,
          username: friend_user.username,
          phone_number: friend_user.phone_number,
          nickname: friend_user.nickname
        }
      end
    end
  
    #return friends array that pushed all of found user objects
    friends
  end

  def pending
    requesting_requests = object.friend_requests_as_requestor.where(friends?: false)

    pendings = []

    requesting_requests.each do |request|
      pending_user = User.find_by(id: request.receiver_id)

      if pending_user
        pendings << {
          id: pending_user.id,
          username: pending_user.username,
          nickname: pending_user.nickname,
          request_id: request.id
        }
      end
    end

    pendings
  end

  def request
    requesting_requests = object.friend_requests_as_receiver.where(friends?: false)

    pendings = []

    requesting_requests.each do |request|
      pending_user = User.find_by(id: request.requestor_id)

      if pending_user
        pendings << {
          id: pending_user.id,
          username: pending_user.username,
          nickname: pending_user.nickname,
          request_id: request.id
        }
      end
    end

    pendings
  end

  def groups_member_of
    memberships = object.members.where(joined: true).all
    groups = memberships.map do |membership|
      membership.friend_group
    end
  end

  def group_invites
    memberships = object.members.where(joined: false).all
    groups = memberships.map do |membership|
      {
        id: membership.id,
        group_id: membership.friend_group.id,
        group_name: membership.friend_group.group_name,
        creator: {
          id: membership.friend_group.user.id,
          username: membership.friend_group.user.username
        }
      }
    end
  end

end
