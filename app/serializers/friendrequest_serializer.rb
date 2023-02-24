class FriendrequestSerializer < ActiveModel::Serializer
  attributes :id, :requestor, :reciever, :friends?

  def requestor
    user = User.find_by(id: object.requestor_id)
  end

  def reciever
    user = User.find_by(id: object.receiver_id)
  end
end
