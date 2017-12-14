class ChangeColumnsNameAndUserIdInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :name, :display_name
    rename_column :users, :userid, :spotify_id
  end
end
