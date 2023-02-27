class Member < ApplicationRecord
  belongs_to :user
  belongs_to :friend_group

  validates_presence_of :user_id, :friend_group_id
  validates_uniqueness_of :user_id, scope: :friend_group_id
end
