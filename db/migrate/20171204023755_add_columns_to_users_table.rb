class AddColumnsToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :profile_img_url, :string
    add_column :users, :userid, :string
    add_column :users, :spotify_url, :string
    add_column :users, :uri, :string
    add_column :users, :access_token, :string
  end
end
