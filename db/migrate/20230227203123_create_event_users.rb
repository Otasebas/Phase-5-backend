class CreateEventUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :event_users do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :calendar_date, null: false, foreign_key: true
      t.boolean :creator
      t.string :attendance
      t.belongs_to :friend_group, null: true, foreign_key: true
      t.boolean :invite_sent

      t.timestamps
    end
  end
end
