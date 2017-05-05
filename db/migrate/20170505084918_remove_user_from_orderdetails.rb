class RemoveUserFromOrderdetails < ActiveRecord::Migration[5.0]
  def change
    remove_column :orderdetails , :order, :string
    remove_column :orderdetails ,:user_id ,:references
    end
end
