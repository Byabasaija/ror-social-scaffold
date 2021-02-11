class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.references :sender, index: true, foreign_key: {to_table: :users}
      t.references :receiver, index:true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
