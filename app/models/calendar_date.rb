class CalendarDate < ApplicationRecord

    has_many :event_users, dependent: :destroy
    has_many :users, through: :event_users

    has_many :event_users, dependent: :destroy
    has_many :friend_groups, through: :event_users

    validates_presence_of :date
    
    validate :start_before_end
    
    validates :start_time, presence: true, uniqueness: { scope: :date, if: -> { event_users.where(creator: true).exists? } }
validates :end_time, presence: true, uniqueness: { scope: :date, if: -> { event_users.where(creator: true).exists? } }

    def start_before_end
        starttime = Time.parse(start_time)
        endtime = Time.parse(end_time)
        if starttime >= endtime
          errors.add(:start_time, "must be before end time")
        end
    end
end
