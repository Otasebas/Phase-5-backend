class PersonalCalendar < ApplicationRecord
  belongs_to :user

  validates_presence_of :date, :name_of_event, :start_time, :end_time, :user_id

  validates :start_time, presence: true, uniqueness: { scope: :date }
  validates :end_time, presence: true, uniqueness: { scope: :date }

  # custom validation to ensure that start_time is before end_time
  validate :start_before_end

  def start_before_end
      start_time_obj = Time.parse(start_time)
      end_time_obj = Time.parse(end_time)
      if start_time_obj >= end_time_obj
        errors.add(:start_time, "must be before end time")
      end

  end

end
