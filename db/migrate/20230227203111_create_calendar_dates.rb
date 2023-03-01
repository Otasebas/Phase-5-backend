class CreateCalendarDates < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_dates do |t|
      t.string :date
      t.string :name_of_event
      t.string :start_time
      t.string :end_time
      t.string :description

      t.timestamps
    end
  end
end
