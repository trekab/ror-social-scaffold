class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :user, index: true,  foreign_key: true
      t.references :pal, index: true
      t.boolean :friendship_status

      t.timestamps
    end
    add_foreign_key :friends, :users, column: :pal_id
  end
end
