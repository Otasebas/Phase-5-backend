class CreateFriendrequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friendrequests do |t|
      t.integer :requestor_id
      t.integer :receiver_id
      t.boolean :friends?

      t.timestamps
    end
  end
end
