class PersonalCalendarSerializer < ActiveModel::Serializer
  attributes :id, :date, :name_of_event, :start_time, :end_time, :description, :username
  
  def username
    object.user.username
  end

end
