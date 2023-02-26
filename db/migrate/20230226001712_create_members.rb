class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :friend_group, null: false, foreign_key: true
      t.boolean :joined

      t.timestamps
    end
  end
end
