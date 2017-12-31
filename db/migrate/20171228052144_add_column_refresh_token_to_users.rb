class AddColumnRefreshTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :refresh_token, :string
  end
end
