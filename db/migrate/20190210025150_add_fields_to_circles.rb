class AddFieldsToCircles < ActiveRecord::Migration[5.2]
  def change
    change_table :circles do |t|
      t.column :abbreviation, :string
      t.column :operational_leader, :string
      t.column :elected_representative, :string
    end
  end
end
