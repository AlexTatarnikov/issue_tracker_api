class AddManagerToIssues < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :manager, index: true, foreign_key: true

    add_index :issues, [:manager_id, :state]
  end
end
