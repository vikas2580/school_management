class AddDefaultToUsersRole < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :role, 2
  end
end
