class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :access_token, :string
    add_column :users, :access_token_secret, :string
    add_column :users, :api_key, :string
    add_column :users, :api_key_secret, :string
  end
end
