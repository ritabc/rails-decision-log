class AddRolesAndAssociations < ActiveRecord::Migration[5.2]
  def change

    change_table :circles do |t|
      t.remove :operational_leader, :elected_representative
    end

    # Rename site admin type and add timestamps for Users
    rename_column :users, :admin_type, :site_amin_type
    add_timestamps :users, null: true
    time = Time.parse('2018-09-14 00:00:00') # One day before any decisions/circles were created
    User.update_all(created_at: time)
    User.update_all(updated_at: time)
    change_column_null :users, :created_at, false
    change_column_null :users, :updated_at, false

    create_table :roles do |t|
      t.string :type
      t.belongs_to :circles, index: true
      t.belongs_to :users, index: true
      t.timestamps
    end
  end
end
