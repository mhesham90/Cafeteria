class FixBugOrderDetails < ActiveRecord::Migration[5.0]
  def change

      remove_foreign_key :orderdetails, column: :user_id

      # remove_column :orderdetails, :user_id, :references, null: false, default: '', index: true
      add_column :orderdetails, :order, :string
  end
end
