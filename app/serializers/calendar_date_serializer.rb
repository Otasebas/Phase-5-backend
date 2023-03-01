class CalendarDateSerializer < ActiveModel::Serializer
  attributes :id, :date, :name_of_event, :start_time, :end_time, :description, :havent_sent, :invitee_status

  def havent_sent
    friends = object.event_users.where(invite_sent:false)

    allmembers = friends.map do |friend|
        invites = {
          id: friend.user.id,
          username: friend.user.username,
          phone_number: friend.user.phone_number,
          nickname: friend.user.nickname,
          avilability: is_available(friend.user, object)
        }
    end

    allmembers
  end

  def is_available (invites, date)
    
    #search for user's personal event dates
    events = invites.event_users.all.where(attendance: "accepted").all

    

    array_of_dates = events.map do |event|
      object = {
        date: event.calendar_date.date,
        start_time: event.calendar_date.start_time,
        end_time: event.calendar_date.end_time
      }
    end

        array_of_dates.any? do |personal_date|
        personal_date_range = (personal_date[:start_time]..personal_date[:end_time])
        incoming_range = (date[:start_time]..date[:end_time])
        personal_date[:date] == date[:date] && personal_date_range.overlaps?(incoming_range)
      end ? false : true

    #check user event date
    
  end

  def invitee_status
    friends = object.event_users.where(invite_sent:true)

    allmembers = friends.map do |friend|
      invites = {
        id: friend.user.id,
        username: friend.user.username,
        phone_number: friend.user.phone_number,
        nickname: friend.user.nickname,
        attendance: friend.attendance
      }
  end
  end
end
