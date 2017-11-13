class AddColumnStateToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :state, :integer, default: 0, null: false
    add_index :issues, [:requester_id, :state]
  end
end
