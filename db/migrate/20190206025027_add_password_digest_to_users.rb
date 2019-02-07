class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :password_digest
      t.remove :password_hash, :password_salt
    end
  end
end
