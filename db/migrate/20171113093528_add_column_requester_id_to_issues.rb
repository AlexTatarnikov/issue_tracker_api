class AddColumnRequesterIdToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :requester_id, :integer, null: false, index: true

    add_foreign_key :issues, :users, column: :requester_id
  end
end
