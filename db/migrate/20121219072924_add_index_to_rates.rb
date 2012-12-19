class AddIndexToRates < ActiveRecord::Migration
  def change
	add_index :reviews, [:user_id, :product_id], :unique => true
	add_index :rates, [:rater_id, :rateable_id], :unique => true 
  end
end
