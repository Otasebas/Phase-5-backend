class FriendGroup < ApplicationRecord
  belongs_to :user

  has_many :members, dependent: :destroy
  has_many :users ,through: :members

    has_many :event_users, dependent: :destroy
    has_many :calendar_dates, through: :event_users

  validates_presence_of :group_name, :user_id
end
