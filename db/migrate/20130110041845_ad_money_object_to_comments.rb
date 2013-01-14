class AdMoneyObjectToComments < ActiveRecord::Migration
  def change
	remove_column :comments, :indicative_price
	add_column :comments, :indicative_price, :money
  end
    
end
