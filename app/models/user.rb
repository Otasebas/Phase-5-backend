class User < ApplicationRecord

    #follows:
    has_many :friend_requests_as_requestor,
        foreign_key: :requestor_id,
        class_name: :Friendrequest

    has_many :friend_requests_as_receiver,
        foreign_key: :receiver_id,
        class_name: :Friendrequest

    has_secure_password

    has_many :personal_calendars
    has_many :friend_groups

    has_many :members
    has_many :friend_groups ,through: :members

    has_many :event_users
    has_many :calendar_dates, through: :event_users

    validates_presence_of :username, :password, :email, :phone_number, :nickname
    validates :username, uniqueness: true
    validates :phone_number, length: { minimum: 9 }
    validates :phone_number, length: { maximum: 11 }
    validates :username, length: { maximum: 20 }
end
