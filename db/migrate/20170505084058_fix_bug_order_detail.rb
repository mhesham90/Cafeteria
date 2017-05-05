class FixBugOrderDetail < ActiveRecord::Migration[5.0]
  def change    
      # add_column :orderdetails, :order, :references
      # add_foreign_key :orderdetails, :order
      add_reference :orderdetails, :order, foreign_key: true

  end
end
