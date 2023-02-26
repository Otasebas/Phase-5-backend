class FriendGroup < ApplicationRecord
  belongs_to :user

  has_many :members, dependent: :destroy
  has_many :users ,through: :members

  validates_presence_of :group_name, :user_id
end
