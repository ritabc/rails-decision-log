class ChangeUserTypeToAdminType < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :type, :admin_type
  end
end
