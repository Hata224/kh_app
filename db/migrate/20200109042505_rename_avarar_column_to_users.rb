class RenameAvararColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :avatar, :avatar_id
  end
end
