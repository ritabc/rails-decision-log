class FixRolesBelongToAssociation < ActiveRecord::Migration[5.2]
  def change
    change_table :roles do |t|
      t.remove_references :circles, :users
      t.belongs_to :circle, index: true
      t.belongs_to :user, index: true
    end
    rename_column :users, :site_amin_type, :site_admin_type
  end
end
