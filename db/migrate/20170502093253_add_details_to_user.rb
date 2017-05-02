class AddDetailsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :image, :string
    add_column :users, :ext, :string
    add_column :users, :admin, :string
    add_reference :users, :room, foreign_key: true
  end
end
