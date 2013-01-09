class Monetizeaddtoad < ActiveRecord::Migration
  def change
	change_table :ads do |t|
	  t.money :price
	end


  end
    
end
