class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.string :notes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
