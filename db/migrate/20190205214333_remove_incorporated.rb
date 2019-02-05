class RemoveIncorporated < ActiveRecord::Migration[5.2]
  def change
    remove_column :decisions, :is_incorporated
  end
end
