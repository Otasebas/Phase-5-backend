class CreatePersonalCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_calendars do |t|
      t.string :date
      t.string :name_of_event
      t.string :start_time
      t.string :end_time
      t.string :description
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
