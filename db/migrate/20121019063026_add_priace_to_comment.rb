class AddPriaceToComment < ActiveRecord::Migration
  def change
    add_column :comments, :price, :float
    add_index :comments, :price
  end
  
end
