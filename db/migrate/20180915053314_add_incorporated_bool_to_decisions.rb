class AddIncorporatedBoolToDecisions < ActiveRecord::Migration[5.2]
  def change
    add_column :decisions, :is_incorporated, :bool
  end
end
