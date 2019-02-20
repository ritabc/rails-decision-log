class RenameRoleTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :roles, :type, :leader_type
  end
end
