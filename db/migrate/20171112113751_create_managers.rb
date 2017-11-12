class CreateManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :managers do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end

    add_index :managers, :email, unique: true
  end
end
