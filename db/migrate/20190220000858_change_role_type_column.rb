class ChangeRoleTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :roles, :leader_type, :role_type
  end
end
