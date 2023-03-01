class EventUser < ApplicationRecord
  
  belongs_to :user
  belongs_to :calendar_date
  belongs_to :friend_group, optional: true

end
