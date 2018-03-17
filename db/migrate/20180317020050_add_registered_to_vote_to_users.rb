class AddRegisteredToVoteToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :registered_to_vote, :boolean, default: false
  end
end
