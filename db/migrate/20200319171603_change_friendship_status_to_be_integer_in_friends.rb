class ChangeFriendshipStatusToBeIntegerInFriends < ActiveRecord::Migration[5.2]
  def change
    change_column :friends, :friendship_status, :integer, using: 'friendship_status::integer', default: 0
  end
end
